import 'package:fikrat_online/features/auth/domain/entities/error_message_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_message.g.dart';

@JsonSerializable()
class ErrorMessageModel extends ErrorMessageEntity {
  const ErrorMessageModel({
    required super.error,
    required super.message,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorMessageModelFromJson(json);
}
