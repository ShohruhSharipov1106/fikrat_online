// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'static_page_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StaticPageModel _$StaticPageModelFromJson(Map<String, dynamic> json) =>
    StaticPageModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      type: json['type'] as String? ?? '',
      source: json['source'] as int? ?? -1,
      updatedAt: json['updated_at'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
    );

Map<String, dynamic> _$StaticPageModelToJson(StaticPageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'source': instance.source,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
