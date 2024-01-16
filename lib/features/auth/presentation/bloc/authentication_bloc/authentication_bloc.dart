import 'dart:async';

import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/features/auth/domain/entities/authentication_status.dart';
import 'package:fikrat_online/features/auth/domain/entities/user_entity.dart';
import 'package:fikrat_online/features/auth/domain/usecases/get_authentication_status_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetAuthenticationStatusUseCase _statusUseCase;
  final GetProfileUseCase _getUserDataUseCase;
  late StreamSubscription<AuthenticationStatus> statusSubscription;
  AuthenticationBloc(
      {required GetAuthenticationStatusUseCase statusUseCase,
      required GetProfileUseCase getUserDataUseCase})
      : _statusUseCase = statusUseCase,
        _getUserDataUseCase = getUserDataUseCase,
        super(const AuthenticationState.unauthenticated()) {
    statusSubscription = _statusUseCase.call(NoParams()).listen((event) {
      add(AuthenticationStatusChanged(status: event));
    });
    on<AuthenticationStatusChanged>((event, emit) async {
      switch (event.status) {
        case AuthenticationStatus.authenticated:
          final userData = await _getUserDataUseCase.call(NoParams());
          if (userData.isRight) {
            await StorageRepository.putBool(
                key: StoreKeys.isAuthenticated, value: true);
            emit(AuthenticationState.authenticated(userData.right));
          } else {
            await StorageRepository.putBool(
                key: StoreKeys.isAuthenticated, value: false);
            await StorageRepository.deleteString(StoreKeys.token);
            emit(const AuthenticationState.unauthenticated());
          }
          break;
        case AuthenticationStatus.unauthenticated:
          await StorageRepository.deleteString(StoreKeys.token);
          await StorageRepository.deleteBool(StoreKeys.isPurchaseRestored);
          emit(
            const AuthenticationState.unauthenticated(),
          );
          break;
      }
    });
  }
  @override
  Future<void> close() {
    statusSubscription.cancel();
    return super.close();
  }
}
