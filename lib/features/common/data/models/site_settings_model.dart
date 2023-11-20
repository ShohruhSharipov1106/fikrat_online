import 'package:json_annotation/json_annotation.dart';
import 'package:fikrat_online/features/common/domain/entities/site_settings_entity.dart';
part 'site_settings_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SiteSettingsModel extends SiteSettingsEntity {
  const SiteSettingsModel({required super.aboutUs, required super.pollDefaultImage, required super.courseAdRate});

  factory SiteSettingsModel.fromJson(Map<String, dynamic> json) => _$SiteSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$SiteSettingsModelToJson(this);
}
