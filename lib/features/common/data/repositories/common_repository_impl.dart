import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/data/datasources/common_datasources.dart';
import 'package:fikrat_online/features/common/domain/repositories/common_repository.dart';

class CommonRepositoryImpl extends CommonRepository {
  CommonDataSource dataSource;

  CommonRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> addToFavotire(String id) async {
    try {
      var result = await dataSource.addToFavorite(id: id);
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
  Future<Either<Failure, bool>> removeFromFavotire(String id) async {
    try {
      var result = await dataSource.removeFromFavorite(id: id);
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
  Future<Either<Failure, bool>> createComplaint({
    required String type,
    required String contentType,
    required String objectId,
    required String description,
    Map<String, dynamic>? token,
  }) async {
    try {
      var result = await dataSource.createComplaint(
        type: type,
        contentType: contentType,
        description: description,
        objectId: objectId,
        token: token,
      );
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
