import 'package:equatable/equatable.dart';
import 'package:fikrat_online/features/common/data/models/brand_logo_model.dart';
import 'package:fikrat_online/features/common/domain/entities/thumbnail_image_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class BrandLogoEntity extends Equatable {
  const BrandLogoEntity({
    this.original = '',
    this.thumbnail = const ThumbnailImageEntity(),
  });

  final String original;
  @ThumbnailImageConverter()
  final ThumbnailImageEntity thumbnail;

  @override
  List<Object?> get props => [original, thumbnail];
}

class BrandLogoConverter<S> implements JsonConverter<BrandLogoEntity, Map<String, dynamic>?> {
  const BrandLogoConverter();

  @override
  BrandLogoEntity fromJson(Map<String, dynamic>? json) => BrandLogoModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(BrandLogoEntity object) => {};
}
