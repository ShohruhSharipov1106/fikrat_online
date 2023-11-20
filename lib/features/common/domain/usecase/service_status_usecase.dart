import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/usecases/usecase.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/common/domain/entities/service_status_entity.dart';
import 'package:fikrat_online/features/common/domain/repositories/site_settings_repository.dart';

class ServiceStatusUseCase extends UseCase<ServiceStatusEntity, NoParams> {
  final SiteSettingsRepo repo;
  ServiceStatusUseCase({required this.repo});
  @override
  Future<Either<Failure, ServiceStatusEntity>> call(NoParams params) async {
    return repo.getServiceStatus();
  }
}
