import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';
import 'package:fikrat_online/features/profile/domain/repositories/profile_course_repository.dart';

class ProfileCourseUseCase extends UseCase<GenericPagination, String?> {
  final ProfileCourseRepository repository;
  ProfileCourseUseCase({required this.repository});
  @override
  Future<Either<Failure, GenericPagination>> call(String? params) {
    return repository.getMyCourses(next: params);
  }
}
