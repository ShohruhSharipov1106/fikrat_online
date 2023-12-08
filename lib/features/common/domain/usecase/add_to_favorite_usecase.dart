import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/domain/repositories/common_repository.dart';

class AddToFavoriteUseCase extends UseCase<bool, String> {
  final CommonRepository repo;
  AddToFavoriteUseCase({required this.repo});
  @override
  Future<Either<Failure, bool>> call(String params) async {
    return repo.addToFavotire(params);
  }
}
