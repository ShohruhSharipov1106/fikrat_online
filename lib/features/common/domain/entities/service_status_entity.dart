import 'package:equatable/equatable.dart';

class ServiceStatusEntity extends Equatable {
  const ServiceStatusEntity({
    this.status = false,
  });

  final bool status;

  @override
  List<Object?> get props => [status];
}
