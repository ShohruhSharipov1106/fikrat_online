import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';
import 'package:fikrat_online/features/profile/data/datasources/profile_course_datasource.dart';
import 'package:fikrat_online/features/profile/domain/repositories/profile_course_repository.dart';

class ProfileCourseRepoImpl extends ProfileCourseRepository {
  final ProfileCourseDataSource dataSource;
  ProfileCourseRepoImpl({required this.dataSource});
  @override
  Future<Either<Failure, GenericPagination>> getMyCourses(
      {String? next}) async {
    try {
      final result = await dataSource.getMyCourse(next: next);
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
