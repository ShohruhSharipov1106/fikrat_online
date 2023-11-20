import 'package:equatable/equatable.dart';

class AboutEntity extends Equatable {
  const AboutEntity({
    this.phone = '',
    this.instagram = '',
    this.twitter = '',
    this.youtube = '',
    this.commeta = '',
  });

  final String phone;
  final String commeta;
  final String youtube;
  final String twitter;
  final String instagram;

  @override
  List<Object?> get props => [
        phone,
        commeta,
        youtube,
        twitter,
        instagram,
      ];
}
