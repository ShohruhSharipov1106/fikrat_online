import 'package:equatable/equatable.dart';
import 'package:fikrat_online/features/common/data/models/posts_model.dart';
import 'package:fikrat_online/features/common/domain/entities/brand_logo_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class PostsEntity extends Equatable {
  final String id;
  final String title;
  @BrandLogoConverter()
  final BrandLogoEntity image;
  final String content;
  final String publishedAt;
  final String shortDescription;
  const PostsEntity({
    this.title = '',
    this.id = "",
    this.content = '',
    this.publishedAt = '',
    this.shortDescription = '',
    this.image = const BrandLogoEntity(),
  });
  @override
  List<Object?> get props => [
        title,
        id,
        image,
        content,
        shortDescription,
        publishedAt,
      ];
}

class PostsConverter implements JsonConverter<PostsEntity, Map<String, dynamic>?> {
  const PostsConverter();
  @override
  PostsEntity fromJson(Map<String, dynamic>? json) => PostsModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(PostsEntity object) => {};
}
