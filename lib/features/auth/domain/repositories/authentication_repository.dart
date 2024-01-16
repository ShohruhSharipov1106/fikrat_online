import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/domain/entities/authentication_status.dart';
import 'package:fikrat_online/features/auth/domain/entities/social_network_type.dart';
import 'package:fikrat_online/features/auth/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  Stream<AuthenticationStatus> statusStream();

  Future<Either<Failure, UserEntity>> getUserData();

  Future<Either<Failure, void>> getLogin({
    required String code,
    required String session,
    required String phone,
  });

  Future<Either<Failure, void>> loginWithSocialNet(
      {required SocialNetworkType socialNetworkType,
      required String? accessToken,
      required String code});

  Future<Either<Failure, String>> submitPhone({required String phone});
}
