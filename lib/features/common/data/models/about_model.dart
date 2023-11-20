import 'package:json_annotation/json_annotation.dart';
import 'package:fikrat_online/features/common/domain/entities/about_entity.dart';

part 'about_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class AboutModel extends AboutEntity {
  const AboutModel({
    required super.phone,
    required super.commeta,
    required super.twitter,
    required super.instagram,
    required super.youtube,
  });

  factory AboutModel.fromJson(Map<String, dynamic> json) => _$AboutModelFromJson(json);

  Map<String, dynamic> toJson() => _$AboutModelToJson(this);
}
