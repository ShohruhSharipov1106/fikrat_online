part of 'site_settings_bloc.dart';

@freezed
class SiteSettingsEvent with _$SiteSettingsEvent {
  const factory SiteSettingsEvent.getSiteSettings() = _GetSiteSettings;

  const factory SiteSettingsEvent.getAboutInformation() = _GetAboutInformation;

  const factory SiteSettingsEvent.getServiceStatus() = _GetServiceStatus;

  const factory SiteSettingsEvent.reCreateBlocEvent() = _ReCreateBlocEvent;
}
