part of 'site_settings_bloc.dart';

@freezed
class SiteSettingsState with _$SiteSettingsState {
  const factory SiteSettingsState({
    @Default(3) int courseAdRate,
    @Default('') String pollDefaultImage,
    @Default('') String aboutUs,
    @Default(FormzSubmissionStatus) status,
    @Default(AboutEntity()) AboutEntity aboutEntity,
    @Default(false) bool serviceStatus,
  }) = _SiteSettingsState;
}
