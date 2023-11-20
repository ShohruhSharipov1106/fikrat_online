part of 'donations_bloc.dart';

class DonationsState extends Equatable {
  final FormzSubmissionStatus donationsStatus;
  final bool donationsFetchMore;
  final String? donationsNext;
  final List<DonationEntity> donations;
  final List<bool> donationsLike;

  const DonationsState({
    this.donationsStatus = FormzSubmissionStatus.initial,
    this.donationsFetchMore = false,
    this.donationsNext,
    this.donations = const [],
    this.donationsLike = const [],
  });
  DonationsState copyWith({
    FormzSubmissionStatus? donationsStatus,
    bool? donationsFetchMore,
    String? donationsNext,
    List<DonationEntity>? donations,
    List<bool>? donationsLike,
  }) =>
      DonationsState(
        donationsStatus: donationsStatus ?? this.donationsStatus,
        donationsFetchMore: donationsFetchMore ?? this.donationsFetchMore,
        donationsNext: donationsNext ?? this.donationsNext,
        donations: donations ?? this.donations,
        donationsLike: donationsLike ?? this.donationsLike,
      );

  @override
  List<Object?> get props => [
        donations,
        donationsNext,
        donationsFetchMore,
        donationsStatus,
        donationsLike,
      ];
}
