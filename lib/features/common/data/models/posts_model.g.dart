// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsModel _$PostsModelFromJson(Map<String, dynamic> json) => PostsModel(
      id: json['id'] as String? ?? "",
      title: json['title'] as String? ?? '',
      content: json['content'] as String? ?? '',
      publishedAt: json['published_at'] as String? ?? '',
      image: json['image'] == null
          ? const BrandLogoEntity()
          : const BrandLogoConverter()
              .fromJson(json['image'] as Map<String, dynamic>?),
      shortDescription: json['short_description'] as String? ?? '',
    );

Map<String, dynamic> _$PostsModelToJson(PostsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': const BrandLogoConverter().toJson(instance.image),
      'content': instance.content,
      'published_at': instance.publishedAt,
      'short_description': instance.shortDescription,
    };
