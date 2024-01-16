import 'package:fikrat_online/features/auth/data/models/error_message.dart';
import 'package:fikrat_online/features/auth/domain/entities/error_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_status.g.dart';

@JsonSerializable()
class ErrorStatusModel extends ErrorStatusEntity {
  const ErrorStatusModel({
    required super.errors,
    required super.statusCode,
  });

  factory ErrorStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorStatusModelFromJson(json);
}
