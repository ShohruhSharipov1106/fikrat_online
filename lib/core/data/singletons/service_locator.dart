import 'package:fikrat_online/core/data/singletons/dio_settings.dart';
import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/features/auth/data/datasources/authentication_datasource.dart';
import 'package:fikrat_online/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:fikrat_online/features/profile/data/datasources/profile_datasource.dart';
import 'package:fikrat_online/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  await StorageRepository.getInstance();

  serviceLocator.registerLazySingleton(() => DioSettings());

  ///
  serviceLocator.registerLazySingleton(
      () => AuthenticationDataSourceImpl(serviceLocator<DioSettings>().dio()));

  serviceLocator.registerLazySingleton(() => AuthenticationRepositoryImpl(
      dataSource: serviceLocator<AuthenticationDataSourceImpl>()));

  ///

  serviceLocator.registerLazySingleton(
      () => ProfileDataSourceImpl(serviceLocator<DioSettings>().dio()));

  serviceLocator.registerLazySingleton(() => ProfileRepositoryImpl(
      profileDatasource: serviceLocator<ProfileDataSourceImpl>()));

  ///

  // serviceLocator.registerLazySingleton(
  //     () => OffertaDataSourceImpl(serviceLokator<DioSettings>().dio(baseUrl: AppConstants.commonUrl)));

  // serviceLocator.registerLazySingleton(() => OffertaRepoImpl(dataSource: serviceLokator<OffertaDataSourceImpl>()));

  ///

  // serviceLocator.registerLazySingleton(
  //     () => ProfileDataSourceImpl(serviceLokator<DioSettings>().dio(baseUrl: AppConstants.baseUrl)));

  // serviceLocator
  //     .registerLazySingleton(() => ProfileRepositoryImpl(profileDatasource: serviceLokator<ProfileDataSourceImpl>()));

  ///
}
