// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generic_pagination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenericPagination<T> _$GenericPaginationFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    GenericPagination<T>(
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results:
          (json['results'] as List<dynamic>?)?.map(fromJsonT).toList() ?? [],
      count: json['count'] as int? ?? 0,
    );

Map<String, dynamic> _$GenericPaginationToJson<T>(
  GenericPagination<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results.map(toJsonT).toList(),
      'count': instance.count,
    };
