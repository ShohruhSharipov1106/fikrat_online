import 'package:json_annotation/json_annotation.dart';
import 'package:fikrat_online/features/common/domain/entities/brand_logo_entity.dart';
import 'package:fikrat_online/features/common/domain/entities/id_title_entity.dart';
import 'package:fikrat_online/features/common/domain/entities/organization_entity.dart';

part 'organization_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrganizationModel extends OrganizationEntity {
  const OrganizationModel({
    required super.id,
    required super.categories,
    required super.brandLogo,
    required super.name,
    required super.projectsCount,
    required super.oldReviewRating,
    required super.type,
    required super.typeDisplay,
    required super.rating,
    required super.reviewCount,
    required super.website,
    required super.isFollowing,
  });

  factory OrganizationModel.fromJson(Map<String, dynamic> json) => _$OrganizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationModelToJson(this);
}
