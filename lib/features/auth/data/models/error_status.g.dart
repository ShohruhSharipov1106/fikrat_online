// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorStatusModel _$ErrorStatusModelFromJson(Map<String, dynamic> json) =>
    ErrorStatusModel(
      errors: (json['errors'] as List<dynamic>?)
              ?.map(
                  (e) => ErrorMessageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      statusCode: json['status_code'] as int? ?? 0,
    );

Map<String, dynamic> _$ErrorStatusModelToJson(ErrorStatusModel instance) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'errors': instance.errors,
    };
