import 'package:fikrat_online/assets/network_locales/domain/repositories/locale_repository.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';

class GetLocaleUseCase extends UseCase<Map<String, dynamic>, NoParams> {
  final LocaleRepository repository;
  GetLocaleUseCase({required this.repository});

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams params) async {
    return await repository.getLocale();
  }
}
