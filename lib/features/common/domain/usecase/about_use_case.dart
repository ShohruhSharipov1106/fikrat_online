import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/domain/entities/about_entity.dart';
import 'package:fikrat_online/features/common/domain/repositories/site_settings_repository.dart';

class AboutUseCase extends UseCase<AboutEntity, NoParams> {
  final SiteSettingsRepo repo;
  AboutUseCase({required this.repo});
  @override
  Future<Either<Failure, AboutEntity>> call(NoParams params) async {
    return repo.getAboutInformations();
  }
}
