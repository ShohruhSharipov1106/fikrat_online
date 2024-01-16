import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/features/auth/domain/entities/login_params.dart';
import 'package:fikrat_online/features/auth/domain/usecases/login_usecase.dart';
import 'package:fikrat_online/features/auth/domain/usecases/submit_phone.dart';
import 'package:fikrat_online/generated/locale_keys.g.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'login_sign_up_event.dart';
part 'login_sign_up_state.dart';

class LoginSignUpBloc extends Bloc<LoginSignUpEvent, LoginSignUpState> {
  final SubmitPhoneUseCase submitPhoneUseCase;
  final LoginUseCase loginUseCase;
  LoginSignUpBloc({
    required this.submitPhoneUseCase,
    required this.loginUseCase,
  }) : super(
          const LoginSignUpState.empty(),
        ) {
    on<SubmitPhone>((event, emit) async {
      print('submit phone');
      final String phoneNumber =
          '+998${event.phone.replaceAll(RegExp('-'), '').replaceAll(' ', '')}';
      emit(state.copyWith(loginStatus: FormzSubmissionStatus.inProgress));
      final result = await submitPhoneUseCase.call(phoneNumber);
      if (result.isRight) {
        event.onSuccess();
        emit(
          state.copyWith(
            loginStatus: FormzSubmissionStatus.success,
            phone: phoneNumber,
            session: result.right,
          ),
        );
      } else {
        if (result.left is DioFailure) {
          event.onError('Error');
        } else if (result.left is ParsingFailure) {
          event.onError((result.left as ParsingFailure).errorMessage);
        } else if (result.left is ServerFailure) {
          if ((result.left as ServerFailure).errorMessage ==
              "The phone number entered is not valid.") {
            event.onError("LocaleKeys.phone_number_is_not_valid.tr()");
          } else {
            event.onError((result.left as ServerFailure).errorMessage);
          }
        }
        emit(state.copyWith(loginStatus: FormzSubmissionStatus.failure));
      }
    });
    on<LoginConfirmEvent>((event, emit) async {
      print('login confirm');
      emit(state.copyWith(submitCodeStatus: FormzSubmissionStatus.inProgress));
      final response = await loginUseCase.call(LoginParams(
          code: event.code, phone: state.phone, session: state.session));
      if (response.isRight) {
        event.onSuccess();
        emit(state.copyWith(loginStatus: FormzSubmissionStatus.success));
      } else {
        if (response.left is DioFailure) {
          event.onError('Error');
        } else if (response.left is ParsingFailure) {
          event.onError((response.left as ParsingFailure).errorMessage);
        } else if (response.left is ServerFailure) {
          event.onError((response.left as ServerFailure).errorMessage);
        }
        emit(state.copyWith(loginStatus: FormzSubmissionStatus.failure));
      }
    });

    on<FocusTextField>((event, emit) {
      emit(state.copyWith(isFocus: event.isFocus));
    });
    on<SetTimer>((event, emit) {
      emit(state.copyWith(secondsLeft: event.secondsLeft));
    });
  }
}
