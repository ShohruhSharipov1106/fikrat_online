import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/profile/domain/repositories/profile_repository.dart';

class SendForChangePhoneUseCase extends UseCase<String, String> {
  final ProfileRepository repository;

  SendForChangePhoneUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(String params) async {
    return await repository.sendCodeForChangePhone(phone: params);
  }
}
