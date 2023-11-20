part of 'advertisement_bloc.dart';

class AdvertisementState extends Equatable {
  final FormzSubmissionStatus advertisementsStatus;
  final bool advertisementsFetchMore;
  final String? advertisementsNext;
  final List<AdvertisementEntity> advertisements;

  const AdvertisementState({
    this.advertisementsStatus = FormzSubmissionStatus.initial,
    this.advertisementsFetchMore = false,
    this.advertisementsNext,
    this.advertisements = const [],
  });
  AdvertisementState copyWith({
    FormzSubmissionStatus? advertisementsStatus,
    bool? advertisementsFetchMore,
    String? advertisementsNext,
    List<AdvertisementEntity>? advertisements,
  }) =>
      AdvertisementState(
        advertisementsStatus: advertisementsStatus ?? this.advertisementsStatus,
        advertisementsFetchMore: advertisementsFetchMore ?? this.advertisementsFetchMore,
        advertisementsNext: advertisementsNext ?? this.advertisementsNext,
        advertisements: advertisements ?? this.advertisements,
      );

  @override
  List<Object?> get props => [
        advertisements,
        advertisementsNext,
        advertisementsFetchMore,
        advertisementsStatus,
      ];
}
