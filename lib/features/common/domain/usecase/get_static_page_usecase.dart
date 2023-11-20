import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/domain/entities/static_page_entity.dart';
import 'package:fikrat_online/features/common/domain/repositories/offerta_repository.dart';
import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';

class GetStaticPageUseCase extends UseCase<GenericPagination<StaticPageEntity>, GetStaticPageParams?> {
  final OffertaRepo repo;
  GetStaticPageUseCase({required this.repo});
  @override
  Future<Either<Failure, GenericPagination<StaticPageEntity>>> call(GetStaticPageParams? params) async {
    return repo.getStaticPage(params: params);
  }
}

class GetStaticPageParams {
  final String? next;
  final String? search;
  final String? source;
  final String? createdAtDateGte;
  final String? createdAtDateLte;
  final int? limit;
  final int? offset;
  const GetStaticPageParams({
    this.next,
    this.search,
    this.offset,
    this.limit,
    this.source,
    this.createdAtDateGte,
    this.createdAtDateLte,
  });
}
