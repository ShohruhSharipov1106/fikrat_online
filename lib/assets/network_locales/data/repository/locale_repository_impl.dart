import 'package:fikrat_online/assets/network_locales/data/datasource/locale_datasource.dart';
import 'package:fikrat_online/assets/network_locales/domain/repositories/locale_repository.dart';
import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final LocaleDataSource dataSource;
  LocaleRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> getLocale() async {
    try {
      final result = await dataSource.getLocale();
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
