import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/domain/entities/about_entity.dart';
import 'package:fikrat_online/features/common/domain/entities/service_status_entity.dart';
import 'package:fikrat_online/features/common/domain/entities/site_settings_entity.dart';

abstract class SiteSettingsRepo {
  Future<Either<Failure, SiteSettingsEntity>> getSiteSettings();
  Future<Either<Failure, AboutEntity>> getAboutInformations();
  Future<Either<Failure, ServiceStatusEntity>> getServiceStatus();
}
