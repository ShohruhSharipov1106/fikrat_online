import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/data/datasources/offerta_datasource.dart';
import 'package:fikrat_online/features/common/domain/repositories/offerta_repository.dart';

class OffertaRepoImpl extends OffertaRepository {
  final OffertaDataSource dataSource;
  OffertaRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, void>> getOfferta() async {
    try {
      final result = await dataSource.getOfferta();
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
