import 'package:json_annotation/json_annotation.dart';
import 'package:fikrat_online/features/common/domain/entities/service_status_entity.dart';
part 'service_status_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ServiceStatusModel extends ServiceStatusEntity {
  const ServiceStatusModel({required super.status});

  factory ServiceStatusModel.fromJson(Map<String, dynamic> json) => _$ServiceStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceStatusModelToJson(this);
}
