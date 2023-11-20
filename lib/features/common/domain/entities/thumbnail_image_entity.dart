import 'package:equatable/equatable.dart';
import 'package:fikrat_online/features/common/data/models/thumbnail_image_model.dart';
import 'package:json_annotation/json_annotation.dart';

class ThumbnailImageEntity extends Equatable {
  final String large;
  final String medium;
  final String small;
  const ThumbnailImageEntity({
    this.large = '',
    this.medium = '',
    this.small = '',
  });
  @override
  List<Object?> get props => [large, medium, small];
}

class ThumbnailImageConverter
    implements JsonConverter<ThumbnailImageEntity, Map<String, dynamic>?> {
  const ThumbnailImageConverter();
  @override
  ThumbnailImageEntity fromJson(Map<String, dynamic>? json) =>
      ThumbnailImageModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(ThumbnailImageEntity object) => {};
}
