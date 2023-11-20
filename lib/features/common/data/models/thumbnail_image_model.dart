import 'package:fikrat_online/features/common/domain/entities/thumbnail_image_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thumbnail_image_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ThumbnailImageModel extends ThumbnailImageEntity {
  const ThumbnailImageModel({
    required super.large,
    required super.medium,
    required super.small,
  });

  factory ThumbnailImageModel.fromJson(Map<String, dynamic> json) =>
      _$ThumbnailImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ThumbnailImageModelToJson(this);
}
