// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thumbnail_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ThumbnailImageModel _$ThumbnailImageModelFromJson(Map<String, dynamic> json) =>
    ThumbnailImageModel(
      large: json['large'] as String? ?? '',
      medium: json['medium'] as String? ?? '',
      small: json['small'] as String? ?? '',
    );

Map<String, dynamic> _$ThumbnailImageModelToJson(
        ThumbnailImageModel instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
      'small': instance.small,
    };
