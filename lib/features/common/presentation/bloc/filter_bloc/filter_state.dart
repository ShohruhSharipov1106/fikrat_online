part of 'filter_bloc.dart';

class FilterState extends Equatable {
  final FormzSubmissionStatus regionsStatus;
  final bool regionsFetchMore;
  final String? regionsNext;
  final List<IdNameEntity> regions;

  final FormzSubmissionStatus lentaSettingsStatus;
  final bool lentaSettingsFetchMore;
  final String? lentaSettingsNext;
  final List<CategoryEntity> lentaSettings;

  // final FormzSubmissionStatus projectTypesStatus;
  // final bool projectTypesFetchMore;
  // final String? projectTypesNext;
  // final List<IdNameEntity> projectTypes;

  final FormzSubmissionStatus fondTypesStatus;
  final bool fondTypesFetchMore;
  final String? fondTypesNext;
  final List<KeyValueEntity> fondTypes;

  final List<String> selectedLentaSettings;
  final List<String> selectedRegions;
  final List<int> selectedFondTypes;
  final bool onlyFollowings;

  // final String selectedProjectType;

  final List<String> confirmedLentaSettings;
  final List<String> confirmedRegions;
  final List<int> confirmedFondTypes;

  // final String confirmedProjectType;

  final List<String> mainConfirmedLentaSettings;
  final List<String> mainConfirmedRegions;
  final List<int> mainConfirmedFondTypes;

  // final String confirmedProjectType;

  const FilterState({
    this.regionsStatus = FormzSubmissionStatus.initial,
    this.regionsFetchMore = false,
    this.regionsNext,
    this.regions = const [],
    this.lentaSettingsStatus = FormzSubmissionStatus.initial,
    this.lentaSettingsFetchMore = false,
    this.lentaSettingsNext,
    this.lentaSettings = const [],
    // this.projectTypesStatus = FormzSubmissionStatus.initial,
    // this.projectTypesFetchMore = false,
    // this.projectTypesNext,
    // this.projectTypes = const [],
    this.fondTypesStatus = FormzSubmissionStatus.initial,
    this.fondTypesFetchMore = false,
    this.fondTypesNext,
    this.fondTypes = const [],
    // this.selectedProjectType = '',
    this.selectedRegions = const [],
    this.selectedFondTypes = const [],
    this.selectedLentaSettings = const [],
    this.onlyFollowings = false,
    // this.confirmedProjectType = '',
    this.confirmedRegions = const [],
    this.confirmedFondTypes = const [],
    this.confirmedLentaSettings = const [],
    // this.mainConfirmedProjectType = '',
    this.mainConfirmedRegions = const [],
    this.mainConfirmedFondTypes = const [],
    this.mainConfirmedLentaSettings = const [],
  });

  FilterState copyWith({
    FormzSubmissionStatus? regionsStatus,
    bool? regionsFetchMore,
    String? regionsNext,
    List<IdNameEntity>? regions,
    FormzSubmissionStatus? lentaSettingsStatus,
    bool? lentaSettingsFetchMore,
    String? lentaSettingsNext,
    List<CategoryEntity>? lentaSettings,
    // FormzSubmissionStatus? projectTypesStatus,
    // bool? projectTypesFetchMore,
    // String? projectTypesNext,
    // List<IdNameEntity>? projectTypes,
    FormzSubmissionStatus? fondTypesStatus,
    bool? fondTypesFetchMore,
    String? fondTypesNext,
    List<KeyValueEntity>? fondTypes,
    List<String>? selectedLentaSettings,
    List<String>? selectedRegions,
    List<int>? selectedFondTypes,
    bool? onlyFollowings,
    // String? selectedProjectType,
    List<String>? confirmedLentaSettings,
    List<String>? confirmedRegions,
    List<int>? confirmedFondTypes,
    // String? confirmedProjectType,
    List<String>? mainConfirmedLentaSettings,
    List<String>? mainConfirmedRegions,
    List<int>? mainConfirmedFondTypes,
    // String? mainConfirmedProjectType,
  }) =>
      FilterState(
        regionsStatus: regionsStatus ?? this.regionsStatus,
        regionsFetchMore: regionsFetchMore ?? this.regionsFetchMore,
        regionsNext: regionsNext ?? this.regionsNext,
        regions: regions ?? this.regions,
        lentaSettingsStatus: lentaSettingsStatus ?? this.lentaSettingsStatus,
        lentaSettingsFetchMore: lentaSettingsFetchMore ?? this.lentaSettingsFetchMore,
        lentaSettingsNext: lentaSettingsNext ?? this.lentaSettingsNext,
        lentaSettings: lentaSettings ?? this.lentaSettings,
        // projectTypesStatus: projectTypesStatus ?? this.projectTypesStatus,
        // projectTypesFetchMore: projectTypesFetchMore ?? this.projectTypesFetchMore,
        // projectTypesNext: projectTypesNext ?? this.projectTypesNext,
        // projectTypes: projectTypes ?? this.projectTypes,
        fondTypesStatus: fondTypesStatus ?? this.fondTypesStatus,
        fondTypesFetchMore: fondTypesFetchMore ?? this.fondTypesFetchMore,
        fondTypesNext: fondTypesNext ?? this.fondTypesNext,
        fondTypes: fondTypes ?? this.fondTypes,
        selectedLentaSettings: selectedLentaSettings ?? this.selectedLentaSettings,
        selectedRegions: selectedRegions ?? this.selectedRegions,
        selectedFondTypes: selectedFondTypes ?? this.selectedFondTypes,
        onlyFollowings: onlyFollowings ?? this.onlyFollowings,
        // selectedProjectType: selectedProjectType ?? this.selectedProjectType,
        confirmedLentaSettings: confirmedLentaSettings ?? this.confirmedLentaSettings,
        confirmedRegions: confirmedRegions ?? this.confirmedRegions,
        confirmedFondTypes: confirmedFondTypes ?? this.confirmedFondTypes,
        // confirmedProjectType: confirmedProjectType ?? this.confirmedProjectType,
        mainConfirmedLentaSettings: mainConfirmedLentaSettings ?? this.mainConfirmedLentaSettings,
        mainConfirmedRegions: mainConfirmedRegions ?? this.mainConfirmedRegions,
        mainConfirmedFondTypes: mainConfirmedFondTypes ?? this.mainConfirmedFondTypes,
        // mainConfirmedProjectType: mainConfirmedProjectType ?? this.mainConfirmedProjectType,
      );

  @override
  List<Object?> get props => [
        regions,
        regionsNext,
        regionsFetchMore,
        regionsStatus,
        lentaSettings,
        lentaSettingsNext,
        lentaSettingsFetchMore,
        lentaSettingsStatus,
        // projectTypes,
        // projectTypesNext,
        // projectTypesFetchMore,
        // projectTypesStatus,
        fondTypes,
        fondTypesNext,
        fondTypesFetchMore,
        fondTypesStatus,
        // selectedProjectType,
        selectedRegions,
        selectedLentaSettings,
        selectedFondTypes,
        onlyFollowings,
        // confirmedProjectType,
        confirmedRegions,
        confirmedLentaSettings,
        confirmedFondTypes,
        // mainConfirmedProjectType,
        mainConfirmedRegions,
        mainConfirmedLentaSettings,
        mainConfirmedFondTypes,
      ];
}
