// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'id_title_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IdTitleModel _$IdTitleModelFromJson(Map<String, dynamic> json) => IdTitleModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      order: json['order'] as int? ?? 0,
    );

Map<String, dynamic> _$IdTitleModelToJson(IdTitleModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'order': instance.order,
      'icon': instance.icon,
    };
