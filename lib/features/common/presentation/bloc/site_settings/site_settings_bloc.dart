import 'package:bloc/bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imkon_care/assets/constants/app_constants.dart';
import 'package:imkon_care/core/data/singletons/dio_settings.dart';
import 'package:imkon_care/core/data/singletons/service_locator.dart';
import 'package:imkon_care/core/usecases/usecase.dart';
import 'package:imkon_care/features/common/data/datasources/site_settings_datasource.dart';
import 'package:imkon_care/features/common/data/repositories/site_settings_repo_impl.dart';
import 'package:imkon_care/features/common/domain/entities/about_entity.dart';
import 'package:imkon_care/features/common/domain/usecase/about_use_case.dart';
import 'package:imkon_care/features/common/domain/usecase/service_status_usecase.dart';
import 'package:imkon_care/features/common/domain/usecase/site_settings_usecase.dart';

part 'site_settings_bloc.freezed.dart';

part 'site_settings_event.dart';

part 'site_settings_state.dart';

class SiteSettingsBloc extends Bloc<SiteSettingsEvent, SiteSettingsState> {
  ServiceStatusUseCase _serviceStatusUseCase = ServiceStatusUseCase(
    repo: SiteSettingsRepoImpl(
        dataSource: SiteSettingsDataSourceImpl(serviceLocator<DioSettings>().dio(baseUrl: AppConstants.baseUrl))),
  );

  SiteSettingsBloc() : super(const SiteSettingsState()) {
    on<_GetSiteSettings>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await SiteSettingsUseCase(
        repo: SiteSettingsRepoImpl(
          dataSource: SiteSettingsDataSourceImpl(serviceLocator<DioSettings>().dio(baseUrl: AppConstants.baseUrl)),
        ),
      ).call(NoParams());
      if (result.isRight) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.success,
            aboutUs: result.right.aboutUs,
            courseAdRate: result.right.courseAdRate,
            pollDefaultImage: result.right.pollDefaultImage,
          ),
        );
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });

    on<_GetAboutInformation>((event, emit) async {
      final result = await AboutUseCase(
        repo: SiteSettingsRepoImpl(
          dataSource: SiteSettingsDataSourceImpl(serviceLocator<DioSettings>().dio(baseUrl: AppConstants.baseUrl)),
        ),
      ).call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(aboutEntity: result.right));
      }
    });

    on<_GetServiceStatus>((event, emit) async {
      final result = await _serviceStatusUseCase.call(NoParams());
      if (result.isRight) {
        emit(state.copyWith(serviceStatus: result.right.status));
        // serviceStatus = result.right.status;
      }
    });

    on<_ReCreateBlocEvent>((event, emit) async {
      _serviceStatusUseCase = ServiceStatusUseCase(
        repo: SiteSettingsRepoImpl(
            dataSource: SiteSettingsDataSourceImpl(serviceLocator<DioSettings>().dio(baseUrl: AppConstants.baseUrl))),
      );
    });
  }
}
