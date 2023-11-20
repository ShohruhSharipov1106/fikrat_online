part of 'advertisement_bloc.dart';

abstract class AdvertisementEvent extends Equatable {
  const AdvertisementEvent();
}

class GetAdvertisements extends AdvertisementEvent {
  final GetDonationsParams? advertisementsParams;
  const GetAdvertisements({this.advertisementsParams});
  @override
  List<Object?> get props => [];
}

class GetMoreAdvertisements extends AdvertisementEvent {
  const GetMoreAdvertisements();
  @override
  List<Object?> get props => [];
}
