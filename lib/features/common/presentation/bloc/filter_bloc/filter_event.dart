part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
}

class GetLentaSettings extends FilterEvent {
  const GetLentaSettings();
  @override
  List<Object?> get props => [];
}

class GetMoreLentaSettings extends FilterEvent {
  const GetMoreLentaSettings();
  @override
  List<Object?> get props => [];
}

class GetRegions extends FilterEvent {
  const GetRegions();
  @override
  List<Object?> get props => [];
}

class GetMoreRegions extends FilterEvent {
  const GetMoreRegions();
  @override
  List<Object?> get props => [];
}

class GetFondTypes extends FilterEvent {
  const GetFondTypes();
  @override
  List<Object?> get props => [];
}

class GetMoreFondTypes extends FilterEvent {
  const GetMoreFondTypes();
  @override
  List<Object?> get props => [];
}

class SelectFilterParameters extends FilterEvent {
  final List<String>? regionIds;
  // final String? selectedProjectTypes;
  final List<String>? lentaSettingsIds;
  final List<int>? fondTypesIds;
  const SelectFilterParameters({
    this.regionIds,
    this.lentaSettingsIds,
    // this.selectedProjectTypes,
    this.fondTypesIds,
  });
  @override
  List<Object?> get props => [regionIds, lentaSettingsIds, fondTypesIds];
}

class SelectMainFilterParameters extends FilterEvent {
  final List<String>? regionIds;
  // final String? selectedProjectTypes;
  final List<String>? lentaSettingsIds;
  final List<int>? fondTypesIds;
  const SelectMainFilterParameters({
    this.regionIds,
    this.lentaSettingsIds,
    // this.selectedProjectTypes,
    this.fondTypesIds,
  });
  @override
  List<Object?> get props => [regionIds, lentaSettingsIds, fondTypesIds];
}

class EqualFilterParams extends FilterEvent {
  const EqualFilterParams();
  @override
  List<Object?> get props => [];
}

class SelectRegions extends FilterEvent {
  final String regionId;
  const SelectRegions({required this.regionId});
  @override
  List<Object?> get props => [];
}

class SelectFondTypes extends FilterEvent {
  final int fondTypesId;
  const SelectFondTypes({required this.fondTypesId});
  @override
  List<Object?> get props => [];
}

// class SelectProjectTypes extends FilterEvent {
//   final String projectTypes;
//   const SelectProjectTypes({required this.projectTypes});
//   @override
//   List<Object?> get props => [];
// }

class SelectLentaSettings extends FilterEvent {
  final String lentaSettingsId;
  const SelectLentaSettings({required this.lentaSettingsId});
  @override
  List<Object?> get props => [];
}

class SelectOrClearAllRegions extends FilterEvent {
  const SelectOrClearAllRegions();
  @override
  List<Object?> get props => [];
}

class SelectOrClearAllFondTypes extends FilterEvent {
  const SelectOrClearAllFondTypes();
  @override
  List<Object?> get props => [];
}

class SelectOrClearAllLentaSettings extends FilterEvent {
  const SelectOrClearAllLentaSettings();
  @override
  List<Object?> get props => [];
}

class ClearProjectType extends FilterEvent {
  const ClearProjectType();
  @override
  List<Object?> get props => [];
}

class ChangeOnlyFollowings extends FilterEvent {
  final bool value;
  const ChangeOnlyFollowings({required this.value});
  @override
  List<Object?> get props => [value];
}
