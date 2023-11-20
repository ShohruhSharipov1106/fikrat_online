// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_logo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BrandLogoModel _$BrandLogoModelFromJson(Map<String, dynamic> json) =>
    BrandLogoModel(
      original: json['original'] as String? ?? '',
      thumbnail: json['thumbnail'] == null
          ? const ThumbnailImageEntity()
          : const ThumbnailImageConverter()
              .fromJson(json['thumbnail'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$BrandLogoModelToJson(BrandLogoModel instance) =>
    <String, dynamic>{
      'original': instance.original,
      'thumbnail': const ThumbnailImageConverter().toJson(instance.thumbnail),
    };
