import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/profile/domain/repositories/profile_repository.dart';

class DeleteUserUseCase extends UseCase<void, String> {
  final ProfileRepository repository;

  DeleteUserUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteUser(sha256: params);
  }
}
