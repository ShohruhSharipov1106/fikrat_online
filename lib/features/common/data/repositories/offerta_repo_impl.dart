import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/data/datasources/offerta_datasource.dart';
import 'package:fikrat_online/features/common/domain/repositories/offerta_repository.dart';
import 'package:fikrat_online/features/common/domain/entities/static_page_entity.dart';
import 'package:fikrat_online/features/common/domain/usecase/get_static_page_usecase.dart';
import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';

class OffertaRepoImpl extends OffertaRepo {
  final OffertaDataSource dataSource;
  OffertaRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, GenericPagination<StaticPageEntity>>> getStaticPage(
      {GetStaticPageParams? params}) async {
    try {
      final result = await dataSource.getStaticPage(params: params);
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
