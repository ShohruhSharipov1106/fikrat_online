import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:fikrat_online/core/data/singletons/service_locator.dart';
import 'package:fikrat_online/features/common/data/repositories/offerta_repo_impl.dart';
import 'package:fikrat_online/features/common/domain/usecase/offerta_usecase.dart';

part 'offerta_event.dart';
part 'offerta_state.dart';

class OffertaBloc extends Bloc<OffertaEvent, OffertaState> {
  final OffertaUseCase useCase =
      OffertaUseCase(repo: serviceLocator<OffertaRepoImpl>());

  OffertaBloc() : super(const OffertaState()) {
    on<GetOfferta>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await useCase.call(event.type);
      if (result.isRight) {
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });
  }
}
