import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/domain/entities/user_entity.dart';
import 'package:fikrat_online/features/auth/domain/repositories/authentication_repository.dart';

class GetUserDataUseCase implements UseCase<UserEntity, NoParams> {
  final AuthenticationRepository repository;
  GetUserDataUseCase({required this.repository});
  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.getUserData();
  }
}
