import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';

abstract class ProfileCourseRepository {
  Future<Either<Failure, GenericPagination>> getMyCourses({String? next});
}
