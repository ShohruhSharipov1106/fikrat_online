import 'package:equatable/equatable.dart';

class SiteSettingsEntity extends Equatable {
  const SiteSettingsEntity({
    this.courseAdRate = 3,
    this.pollDefaultImage = '',
    this.aboutUs = '',
  });

  final int courseAdRate;
  final String pollDefaultImage;
  final String aboutUs;

  @override
  List<Object?> get props => [courseAdRate, pollDefaultImage, aboutUs];
}
