import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';

abstract class CommonRepository {
  Future<Either<Failure, bool>> addToFavotire(String id);
}
