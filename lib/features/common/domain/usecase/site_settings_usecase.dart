import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/domain/entities/site_settings_entity.dart';
import 'package:fikrat_online/features/common/domain/repositories/site_settings_repository.dart';

class SiteSettingsUseCase extends UseCase<SiteSettingsEntity, NoParams> {
  final SiteSettingsRepo repo;
  SiteSettingsUseCase({required this.repo});
  @override
  Future<Either<Failure, SiteSettingsEntity>> call(NoParams params) async {
    return repo.getSiteSettings();
  }
}
