import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/domain/entities/login_params.dart';
import 'package:fikrat_online/features/auth/domain/repositories/authentication_repository.dart';

class LoginUseCase extends UseCase<void, LoginParams> {
  final AuthenticationRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(LoginParams params) async {
    return await repository.getLogin(
      code: params.code,
      session: params.session,
      phone: params.phone,
    );
  }
}
