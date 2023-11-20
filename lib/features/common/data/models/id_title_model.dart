import 'package:fikrat_online/features/common/domain/entities/id_title_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'id_title_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class IdTitleModel extends IdTitleEntity {
  const IdTitleModel({
    required super.id,
    required super.title,
    required super.icon,
    required super.order,
  });

  factory IdTitleModel.fromJson(Map<String, dynamic> json) => _$IdTitleModelFromJson(json);

  Map<String, dynamic> toJson() => _$IdTitleModelToJson(this);
}
