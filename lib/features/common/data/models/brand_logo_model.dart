import 'package:json_annotation/json_annotation.dart';
import 'package:fikrat_online/features/common/domain/entities/brand_logo_entity.dart';
import 'package:fikrat_online/features/common/domain/entities/thumbnail_image_entity.dart';

part 'brand_logo_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class BrandLogoModel extends BrandLogoEntity {
  const BrandLogoModel({
    required super.original,
    required super.thumbnail,
  });

  factory BrandLogoModel.fromJson(Map<String, dynamic> json) => _$BrandLogoModelFromJson(json);

  Map<String, dynamic> toJson() => _$BrandLogoModelToJson(this);
}
