import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';

abstract class OffertaRepository {
  Future<Either<Failure, void>> getOfferta();
}
