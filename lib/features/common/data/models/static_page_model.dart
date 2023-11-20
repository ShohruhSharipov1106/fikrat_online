import 'package:fikrat_online/features/common/domain/entities/static_page_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'static_page_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class StaticPageModel extends StaticPageEntity {
  const StaticPageModel({
    required super.id,
    required super.title,
    required super.type,
    required super.source,
    required super.updatedAt,
    required super.createdAt,
  });

  factory StaticPageModel.fromJson(Map<String, dynamic> json) => _$StaticPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$StaticPageModelToJson(this);
}
