// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationModel _$OrganizationModelFromJson(Map<String, dynamic> json) =>
    OrganizationModel(
      id: json['id'] as String? ?? '',
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) =>
                  const IdTitleConverter().fromJson(e as Map<String, dynamic>?))
              .toList() ??
          const [],
      brandLogo: json['brand_logo'] == null
          ? const BrandLogoEntity()
          : const BrandLogoConverter()
              .fromJson(json['brand_logo'] as Map<String, dynamic>?),
      name: json['name'] as String? ?? '',
      projectsCount: json['projects_count'] as int? ?? 0,
      oldReviewRating: (json['old_review_rating'] as num?)?.toDouble() ?? 0,
      type: json['type'] as int? ?? -1,
      typeDisplay: json['type_display'] as String? ?? '',
      rating: json['rating'] as String? ?? '',
      reviewCount: json['review_count'] as int? ?? 0,
      website: json['website'] as String? ?? '',
      isFollowing: json['is_following'] as bool? ?? false,
    );

Map<String, dynamic> _$OrganizationModelToJson(OrganizationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'brand_logo': const BrandLogoConverter().toJson(instance.brandLogo),
      'type_display': instance.typeDisplay,
      'type': instance.type,
      'categories':
          instance.categories.map(const IdTitleConverter().toJson).toList(),
      'website': instance.website,
      'rating': instance.rating,
      'review_count': instance.reviewCount,
      'projects_count': instance.projectsCount,
      'old_review_rating': instance.oldReviewRating,
      'is_following': instance.isFollowing,
    };
