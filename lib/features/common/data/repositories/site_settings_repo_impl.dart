import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/data/datasources/site_settings_datasource.dart';
import 'package:fikrat_online/features/common/domain/entities/about_entity.dart';
import 'package:fikrat_online/features/common/domain/entities/service_status_entity.dart';
import 'package:fikrat_online/features/common/domain/entities/site_settings_entity.dart';
import 'package:fikrat_online/features/common/domain/repositories/site_settings_repository.dart';

class SiteSettingsRepoImpl extends SiteSettingsRepo {
  final SiteSettingsDataSource dataSource;
  SiteSettingsRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, SiteSettingsEntity>> getSiteSettings() async {
    try {
      final result = await dataSource.getSiteSettings();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          statusCode: e.statusCode, errorMessage: e.errorMessage));
    } on DioExceptions catch (e) {
      return Left(
          DioFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, AboutEntity>> getAboutInformations() async {
    try {
      final result = await dataSource.getAboutInformation();
      return Right(result);
   } on ServerException catch (e) {
      return Left(ServerFailure(
          statusCode: e.statusCode, errorMessage: e.errorMessage));
    } on DioExceptions catch (e) {
      return Left(
          DioFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, ServiceStatusEntity>> getServiceStatus() async {
    try {
      final result = await dataSource.getServiceStatus();
      return Right(result);
   } on ServerException catch (e) {
      return Left(ServerFailure(
          statusCode: e.statusCode, errorMessage: e.errorMessage));
    } on DioExceptions catch (e) {
      return Left(
          DioFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }
}
