import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/domain/entities/user_entity.dart';
import 'package:fikrat_online/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase extends UseCase<UserEntity, NoParams> {
  final ProfileRepository profileRepository;

  GetProfileUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await profileRepository.getProfile();
  }
}
