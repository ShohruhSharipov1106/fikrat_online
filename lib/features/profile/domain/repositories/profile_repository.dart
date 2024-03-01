import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/domain/entities/authentication_status.dart';
import 'package:fikrat_online/features/auth/domain/entities/user_entity.dart';
import 'package:fikrat_online/features/profile/domain/usecases/update_profile.dart';

abstract class ProfileRepository {
  Stream<AuthenticationStatus> statusStream();
  const ProfileRepository();
  Future<Either<Failure, void>> changePhone({
    required String code,
    required String session,
    required String phone,
  });
  Future<Either<Failure, String>> sendCodeForChangePhone(
      {required String phone});
  Future<Either<Failure, String>> checkUserName({required String userName});
  Future<Either<Failure, void>> deleteUser({required String sha256});
  Future<Either<Failure, UserEntity>> getProfile();
  Future<Either<Failure, UserEntity>> updateProfile(FilePathParams params);
}
