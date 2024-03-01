import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/domain/entities/user_entity.dart';
import 'package:fikrat_online/features/profile/domain/repositories/profile_repository.dart';

class UpdateProfileUseCase extends UseCase<UserEntity, FilePathParams> {
  final ProfileRepository profileRepository;

  UpdateProfileUseCase({required this.profileRepository});

  @override
  Future<Either<Failure, UserEntity>> call(FilePathParams params) async {
    return await profileRepository.updateProfile(
      FilePathParams(
        fullName: params.fullName,
        bio: params.bio,
        userName: params.userName,
        email: params.email,
        imagePath: params.imagePath,
        phoneNumber: params.phoneNumber,
      ),
    );
  }
}

class FilePathParams {
  String? fullName;
  String? bio;
  String? userName;
  String? email;
  String? imagePath;
  String? phoneNumber;
  FilePathParams({
    this.fullName,
    this.bio,
    this.userName,
    this.email,
    this.imagePath,
    this.phoneNumber,
  });
}
