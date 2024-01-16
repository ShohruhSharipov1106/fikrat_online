import 'package:fikrat_online/core/data/singletons/dio_settings.dart';
import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.I;

Future<void> setupLocator() async {
  await StorageRepository.getInstance();

  serviceLocator.registerLazySingleton(() => DioSettings());

  ///
  // serviceLocator
  //     .registerLazySingleton(() => AuthenticationDataSourceImpl(serviceLokator<DioSettings>().dio(baseUrl: baseIdUrl)));

  // serviceLocator.registerLazySingleton(
  //     () => AuthenticationRepositoryImpl(dataSource: serviceLokator<AuthenticationDataSourceImpl>()));

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
