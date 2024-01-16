// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorMessageModel _$ErrorMessageModelFromJson(Map<String, dynamic> json) =>
    ErrorMessageModel(
      error: json['error'] as String? ?? '',
      message: json['message'] as String? ?? '',
    );

Map<String, dynamic> _$ErrorMessageModelToJson(ErrorMessageModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
