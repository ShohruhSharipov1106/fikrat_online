import 'package:fikrat_online/features/common/domain/entities/brand_logo_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fikrat_online/features/common/domain/entities/posts_entity.dart';

part 'posts_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PostsModel extends PostsEntity {
  const PostsModel({
    required super.id,
    required super.title,
    required super.content,
    required super.publishedAt,
    required super.image,
    required super.shortDescription,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => _$PostsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostsModelToJson(this);
}
