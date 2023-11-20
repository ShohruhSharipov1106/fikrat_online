import 'package:equatable/equatable.dart';
import 'package:fikrat_online/features/common/data/models/organization_model.dart';
import 'package:fikrat_online/features/common/domain/entities/brand_logo_entity.dart';
import 'package:fikrat_online/features/common/domain/entities/id_title_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class OrganizationEntity extends Equatable {
  const OrganizationEntity({
    this.id = '',
    this.name = '',
    this.brandLogo = const BrandLogoEntity(),
    this.type = -1,
    this.typeDisplay = '',
    this.categories = const [],
    this.projectsCount = 0,
    this.oldReviewRating = 0,
    this.rating = '',
    this.website = '',
    this.reviewCount = 0,
    this.isFollowing = false,
  });

  final String id;
  final String name;
  @BrandLogoConverter()
  final BrandLogoEntity brandLogo;
  final String typeDisplay;
  final int type;
  @IdTitleConverter()
  final List<IdTitleEntity> categories;
  final String website;
  final String rating;
  final int reviewCount;
  final int projectsCount;
  final double oldReviewRating;
  final bool isFollowing;

  @override
  List<Object?> get props => [
        id,
        name,
        brandLogo,
        oldReviewRating,
        type,
        categories,
        projectsCount,
        rating,
        reviewCount,
        website,
        isFollowing,
      ];
}

class OrganizationConverter<S> implements JsonConverter<OrganizationEntity, Map<String, dynamic>?> {
  const OrganizationConverter();

  @override
  OrganizationEntity fromJson(Map<String, dynamic>? json) => OrganizationModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(OrganizationEntity object) => {};
}
