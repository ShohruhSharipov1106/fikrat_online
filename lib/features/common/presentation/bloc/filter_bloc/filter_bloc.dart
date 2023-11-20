import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:imkon_care/core/data/singletons/service_locator.dart';
import 'package:imkon_care/features/common/data/repositories/common_repository_impl.dart';
import 'package:imkon_care/features/common/domain/usecase/get_fond_types_usecase.dart';
import 'package:imkon_care/features/profile/domain/entity/key_value_entity.dart';
import 'package:imkon_care/features/region/data/repositories/region_repository_impl.dart';
import 'package:imkon_care/features/region/domain/use_cases/get_regions_usecase.dart';
import 'package:imkon_care/features/search/data/repository/categories_repo_impl.dart';
import 'package:imkon_care/features/search/domain/entities/category_entity.dart';
import 'package:imkon_care/features/search/domain/usecases/category_use_case.dart';
import 'package:imkon_care/features/single_donation/domain/entities/id_name_entity.dart';

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final GetRegionsUseCase _getRegionsUsecase = GetRegionsUseCase(repository: serviceLocator<RegionRepositoryImpl>());
  final CategoriesUseCase _categoriesUseCase = CategoriesUseCase(repo: serviceLocator<CategriesRepositoryImpl>());
  final GetFondTypesUseCase _getFondTypesUsecase =
      GetFondTypesUseCase(repository: serviceLocator<CommonRepositoryImpl>());

  FilterBloc() : super(const FilterState()) {
    on<GetLentaSettings>(_getLentaSettings);
    on<GetMoreLentaSettings>(_getMoreLentaSettings);
    on<GetRegions>(_getRegions);
    on<GetMoreRegions>(_getMoreRegions);
    on<GetFondTypes>(_getFondTypes);
    on<GetMoreFondTypes>(_getMoreFondTypes);
    on<SelectFilterParameters>(_selectFilterParameters);
    on<SelectMainFilterParameters>(_selectMainFilterParameters);
    on<SelectRegions>(_selectRegions);
    on<SelectFondTypes>(_selectFondTypes);
    on<SelectLentaSettings>(_selectLentaSettings);
    // on<SelectProjectTypes>(_selectProjectTypes);
    on<EqualFilterParams>(_equalFilterParams);
    on<SelectOrClearAllRegions>(_selectOrClearAllRegions);
    on<SelectOrClearAllFondTypes>(_selectOrClearAllFondTypes);
    on<SelectOrClearAllLentaSettings>(_selectOrClearAllLentaSettings);
    on<ClearProjectType>(_clearProjectType);
    on<ChangeOnlyFollowings>(_changeOnlyFollowings);
  }

  _getLentaSettings(GetLentaSettings event, Emitter<FilterState> emit) async {
    emit(state.copyWith(lentaSettingsStatus: FormzSubmissionStatus.inProgress));
    final result = await _categoriesUseCase.call(null);
    if (result.isRight) {
      emit(state.copyWith(
        lentaSettingsStatus: FormzSubmissionStatus.success,
        lentaSettings: result.right.results,
        lentaSettingsFetchMore: result.right.next != null,
        lentaSettingsNext: result.right.next,
      ));
    }
  }

  _getMoreLentaSettings(GetMoreLentaSettings event, Emitter<FilterState> emit) async {
    final result = await _categoriesUseCase.call(state.lentaSettingsNext);
    if (result.isRight) {
      emit(state.copyWith(
        lentaSettings: [...state.lentaSettings, ...result.right.results],
        lentaSettingsFetchMore: result.right.next != null,
        lentaSettingsNext: result.right.next,
      ));
    }
  }

  _getRegions(GetRegions event, Emitter<FilterState> emit) async {
    emit(state.copyWith(regionsStatus: FormzSubmissionStatus.inProgress));
    final result = await _getRegionsUsecase.call(null);
    if (result.isRight) {
      emit(state.copyWith(
        regionsStatus: FormzSubmissionStatus.success,
        regions: result.right.results,
        regionsFetchMore: result.right.next != null,
        regionsNext: result.right.next,
      ));
    }
  }

  _getMoreRegions(GetMoreRegions event, Emitter<FilterState> emit) async {
    final result = await _getRegionsUsecase.call(GetRegionParams(next: state.regionsNext));
    if (result.isRight) {
      emit(state.copyWith(
        regions: [...state.regions, ...result.right.results],
        regionsFetchMore: result.right.next != null,
        regionsNext: result.right.next,
      ));
    }
  }

  _getFondTypes(GetFondTypes event, Emitter<FilterState> emit) async {
    emit(state.copyWith(fondTypesStatus: FormzSubmissionStatus.inProgress));
    final result = await _getFondTypesUsecase.call(null);
    if (result.isRight) {
      emit(state.copyWith(
        fondTypesStatus: FormzSubmissionStatus.success,
        fondTypes: result.right.choices,
      ));
    }
  }

  _getMoreFondTypes(GetMoreFondTypes event, Emitter<FilterState> emit) async {
    final result = await _getFondTypesUsecase.call(GetRegionParams(next: state.fondTypesNext));
    if (result.isRight) {
      emit(state.copyWith(fondTypes: [...state.fondTypes, ...result.right.choices]));
    }
  }

  _selectFilterParameters(SelectFilterParameters event, Emitter<FilterState> emit) async {
    if (event.regionIds != null) {
      emit(state.copyWith(confirmedRegions: event.regionIds));
    }
    // else if (event.selectedProjectTypes != null) {
    //   emit(
    //     state.copyWith(confirmedProjectType: event.selectedProjectTypes),
    //   );
    // }
    else if (event.lentaSettingsIds != null) {
      emit(state.copyWith(confirmedLentaSettings: event.lentaSettingsIds));
    } else if (event.fondTypesIds != null) {
      emit(state.copyWith(confirmedFondTypes: event.fondTypesIds));
    }
  }

  _selectMainFilterParameters(SelectMainFilterParameters event, Emitter<FilterState> emit) async {
    if (event.regionIds != null) {
      emit(state.copyWith(mainConfirmedRegions: event.regionIds));
    }
    // else if (event.selectedProjectTypes != null) {
    //   emit(
    //     state.copyWith(mainConfirmedProjectType: event.selectedProjectTypes),
    //   );
    // }
    if (event.lentaSettingsIds != null) {
      emit(state.copyWith(mainConfirmedLentaSettings: event.lentaSettingsIds));
    }
    if (event.fondTypesIds != null) {
      emit(state.copyWith(mainConfirmedFondTypes: event.fondTypesIds));
    }
  }

  _equalFilterParams(EqualFilterParams event, Emitter<FilterState> emit) async {
    emit(
      state.copyWith(
        selectedRegions: state.confirmedRegions,
        selectedLentaSettings: state.confirmedLentaSettings,
        // selectedProjectType: state.confirmedProjectType,
        selectedFondTypes: state.confirmedFondTypes,
      ),
    );
  }

  _selectRegions(SelectRegions event, Emitter<FilterState> emit) async {
    if (state.selectedRegions.contains(event.regionId)) {
      final List<String> lists = [...state.selectedRegions];
      lists.removeWhere((element) => element == event.regionId);
      emit(state.copyWith(selectedRegions: lists));
    } else {
      final List<String> lists = [...state.selectedRegions, event.regionId];

      emit(state.copyWith(selectedRegions: lists));
    }
  }

  _selectFondTypes(SelectFondTypes event, Emitter<FilterState> emit) async {
    if (state.selectedFondTypes.contains(event.fondTypesId)) {
      final List<int> lists = [...state.selectedFondTypes];
      lists.removeWhere((element) => element == event.fondTypesId);
      emit(state.copyWith(selectedFondTypes: lists));
    } else {
      final List<int> lists = [...state.selectedFondTypes, event.fondTypesId];
      emit(state.copyWith(selectedFondTypes: lists));
    }
  }

  _selectLentaSettings(SelectLentaSettings event, Emitter<FilterState> emit) async {
    if (state.selectedLentaSettings.indexWhere((element) => element == event.lentaSettingsId) > -1) {
      final List<String> lists = [...state.selectedLentaSettings];
      lists.removeWhere((element) => element == event.lentaSettingsId);
      emit(state.copyWith(selectedLentaSettings: lists));
    } else {
      final List<String> lists = [...state.selectedLentaSettings, event.lentaSettingsId];

      emit(state.copyWith(selectedLentaSettings: lists));
    }
  }

  // _selectProjectTypes(SelectProjectTypes event, Emitter<FilterState> emit) async {
  //   emit(state.copyWith(selectedProjectType: event.projectTypes));
  // }

  _selectOrClearAllRegions(SelectOrClearAllRegions event, Emitter<FilterState> emit) async {
    if (state.selectedRegions.length != state.regions.length || state.confirmedRegions.length != state.regions.length) {
      emit(
        state.copyWith(
          selectedRegions: state.regions.map((e) => e.id).toList(),
          confirmedRegions: state.regions.map((e) => e.id).toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedRegions: [],
          confirmedRegions: [],
        ),
      );
    }
  }

  _selectOrClearAllFondTypes(SelectOrClearAllFondTypes event, Emitter<FilterState> emit) async {
    if (state.selectedFondTypes.length != state.fondTypes.length ||
        state.confirmedFondTypes.length != state.fondTypes.length) {
      emit(
        state.copyWith(
          selectedFondTypes: state.fondTypes.map((e) => e.key).toList(),
          confirmedFondTypes: state.fondTypes.map((e) => e.key).toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedFondTypes: [],
          confirmedFondTypes: [],
        ),
      );
    }
  }

  _selectOrClearAllLentaSettings(SelectOrClearAllLentaSettings event, Emitter<FilterState> emit) async {
    if (state.selectedLentaSettings.length != state.lentaSettings.length ||
        state.confirmedLentaSettings.length != state.lentaSettings.length) {
      emit(
        state.copyWith(
          selectedLentaSettings: state.lentaSettings.map((e) => e.id).toList(),
          confirmedLentaSettings: state.lentaSettings.map((e) => e.id).toList(),
        ),
      );
    } else {
      emit(
        state.copyWith(
          selectedLentaSettings: [],
          confirmedLentaSettings: [],
        ),
      );
    }
  }

  _clearProjectType(ClearProjectType event, Emitter<FilterState> emit) async {
    emit(
      state.copyWith(
        // selectedProjectType: '',
        // confirmedProjectType: '',
        selectedLentaSettings: [],
        selectedRegions: [],
        selectedFondTypes: [],
        confirmedRegions: [],
        confirmedLentaSettings: [],
        confirmedFondTypes: [],
        mainConfirmedRegions: [],
        mainConfirmedLentaSettings: [],
        mainConfirmedFondTypes: [],
        onlyFollowings: false,
      ),
    );
  }

  _changeOnlyFollowings(ChangeOnlyFollowings event, Emitter<FilterState> emit) async {
    emit(state.copyWith(onlyFollowings: event.value));
  }
}
