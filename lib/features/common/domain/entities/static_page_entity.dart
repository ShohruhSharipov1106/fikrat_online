import 'package:equatable/equatable.dart';
import 'package:fikrat_online/features/common/data/models/static_page_model.dart';
import 'package:json_annotation/json_annotation.dart';

class StaticPageEntity extends Equatable {
  final String id;
  final String title;
  final String type;
  final int source;
  final String createdAt;
  final String updatedAt;

  const StaticPageEntity({
    this.id = '',
    this.title = '',
    this.type = '',
    this.source = -1,
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  List<Object?> get props => [];
}

class StaticPageConverter implements JsonConverter<StaticPageEntity, Map<String, dynamic>?> {
  const StaticPageConverter();
  @override
  StaticPageEntity fromJson(Map<String, dynamic>? json) => StaticPageModel.fromJson(json ?? {});

  @override
  Map<String, dynamic>? toJson(StaticPageEntity object) => {};
}
