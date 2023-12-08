import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';

abstract class LocaleRepository {
  Future<Either<Failure, Map<String, dynamic>>> getLocale();
}
