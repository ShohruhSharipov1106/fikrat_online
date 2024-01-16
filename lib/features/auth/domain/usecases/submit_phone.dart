import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/domain/repositories/authentication_repository.dart';

class SubmitPhoneUseCase extends UseCase<String, String> {
  final AuthenticationRepository repository;

  SubmitPhoneUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(String params) async {
    return await repository.submitPhone(phone: params);
  }
}
