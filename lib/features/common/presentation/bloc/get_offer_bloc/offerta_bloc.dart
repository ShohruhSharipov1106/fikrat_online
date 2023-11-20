import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:imkon_care/core/data/singletons/service_locator.dart';
import 'package:imkon_care/features/common/data/repositories/offerta_repo_impl.dart';
import 'package:imkon_care/features/common/domain/entities/static_page_detail_entity.dart';
import 'package:imkon_care/features/common/domain/usecase/get_static_page_usecase.dart';
import 'package:imkon_care/features/common/domain/usecase/offerta_usecase.dart';

part 'offerta_event.dart';
part 'offerta_state.dart';

class OffertaBloc extends Bloc<OffertaEvent, OffertaState> {
  final OffertaUseCase useCase = OffertaUseCase(repo: serviceLocator<OffertaRepoImpl>());
  final GetStaticPageUseCase _staticPageUseCase = GetStaticPageUseCase(repo: serviceLocator<OffertaRepoImpl>());

  OffertaBloc() : super(const OffertaState()) {
    on<GetOfferta>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await useCase.call(event.type);
      if (result.isRight) {
        emit(state.copyWith(content: result.right, status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });
    on<GetStaticPage>((event, emit) async {
      emit(state.copyWith(staticPageStatus: FormzSubmissionStatus.inProgress));
      final result = await _staticPageUseCase.call(event.params);
      if (result.isRight) {
        emit(state.copyWith(
          searchedType: result.right.results.isNotEmpty ? result.right.results.first.type : "",
          staticPageStatus: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(staticPageStatus: FormzSubmissionStatus.failure));
      }
    });
  }
}
