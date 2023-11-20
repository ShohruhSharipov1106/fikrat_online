// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SiteSettingsModel _$SiteSettingsModelFromJson(Map<String, dynamic> json) =>
    SiteSettingsModel(
      aboutUs: json['about_us'] as String? ?? '',
      pollDefaultImage: json['poll_default_image'] as String? ?? '',
      courseAdRate: json['course_ad_rate'] as int? ?? 3,
    );

Map<String, dynamic> _$SiteSettingsModelToJson(SiteSettingsModel instance) =>
    <String, dynamic>{
      'course_ad_rate': instance.courseAdRate,
      'poll_default_image': instance.pollDefaultImage,
      'about_us': instance.aboutUs,
    };
