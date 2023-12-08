import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/domain/repositories/offerta_repository.dart';

class OffertaUseCase extends UseCase<void, String> {
  final OffertaRepository repo;
  OffertaUseCase({required this.repo});
  @override
  Future<Either<Failure, void>> call(String params) async {
    return repo.getOfferta();
  }
}
