import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/domain/entities/static_page_entity.dart';
import 'package:fikrat_online/features/common/domain/usecase/get_static_page_usecase.dart';
import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';

abstract class OffertaRepo {
  Future<Either<Failure, GenericPagination<StaticPageEntity>>> getStaticPage({GetStaticPageParams? params});
 }
