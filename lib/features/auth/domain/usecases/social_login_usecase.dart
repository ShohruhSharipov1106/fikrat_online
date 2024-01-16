import 'package:fikrat_online/core/data/singletons/service_locator.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/data/repositories/authentication_repository_impl.dart';
import 'package:fikrat_online/features/auth/domain/entities/social_network_type.dart';
import 'package:fikrat_online/features/auth/domain/repositories/authentication_repository.dart';

class SocialLoginUseCase extends UseCase<void, SocialLoginParams> {
  final AuthenticationRepository _repository =
      serviceLocator<AuthenticationRepositoryImpl>();

  @override
  Future<Either<Failure, void>> call(SocialLoginParams params) async {
    return await _repository.loginWithSocialNet(
        socialNetworkType: params.type,
        accessToken: params.accessToken,
        code: params.code);
  }
}

class SocialLoginParams {
  final String? accessToken;
  final String code;
  final SocialNetworkType type;

  const SocialLoginParams(
      {required this.type, required this.code, required this.accessToken});
}
