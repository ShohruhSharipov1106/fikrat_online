import 'package:equatable/equatable.dart';
import 'package:fikrat_online/features/common/data/models/id_title_model.dart';
import 'package:json_annotation/json_annotation.dart';

class IdTitleEntity extends Equatable {
  const IdTitleEntity({
    this.id = '',
    this.title = '',
    this.order = 0,
    this.icon = '',
  });

  final String id;
  final String title;
  final int order;
  final String icon;

  @override
  List<Object?> get props => [
        id,
        title,
        order,
        icon,
      ];
}

class IdTitleConverter<S> implements JsonConverter<IdTitleEntity, Map<String, dynamic>?> {
  const IdTitleConverter();

  @override
  IdTitleEntity fromJson(Map<String, dynamic>? json) => IdTitleModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(IdTitleEntity object) => {};
}
