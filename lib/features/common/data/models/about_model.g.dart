// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'about_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AboutModel _$AboutModelFromJson(Map<String, dynamic> json) => AboutModel(
      phone: json['phone'] as String? ?? '',
      commeta: json['commeta'] as String? ?? '',
      twitter: json['twitter'] as String? ?? '',
      instagram: json['instagram'] as String? ?? '',
      youtube: json['youtube'] as String? ?? '',
    );

Map<String, dynamic> _$AboutModelToJson(AboutModel instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'commeta': instance.commeta,
      'youtube': instance.youtube,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
    };
