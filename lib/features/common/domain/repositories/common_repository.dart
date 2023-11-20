import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';

abstract class CommonRepository {
  Future<Either<Failure, bool>> addToFavotire(String id);

  Future<Either<Failure, bool>> removeFromFavotire(String id);

  Future<Either<Failure, bool>> createComplaint({
    required String type,
    required String contentType,
    required String objectId,
    required String description,
    Map<String, dynamic>? token,
  });

}
