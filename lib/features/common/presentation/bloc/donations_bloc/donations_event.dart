part of 'donations_bloc.dart';

abstract class DonationsEvent extends Equatable {
  const DonationsEvent();
}

class GetDonations extends DonationsEvent {
  final GetDonationsParams? donationsParams;

  const GetDonations({this.donationsParams});

  @override
  List<Object?> get props => [];
}

class GetMoreDonations extends DonationsEvent {
  const GetMoreDonations();

  @override
  List<Object?> get props => [];
}

class CreateDonationShare extends DonationsEvent {
  final CreateDonationShareParams params;

  const CreateDonationShare({required this.params});

  @override
  List<Object?> get props => [params];
}

class AddToFavourite extends DonationsEvent {
  final String id;

  const AddToFavourite({required this.id});

  @override
  List<Object?> get props => [id];
}

class CreateComplaintDonation extends DonationsEvent {
  final String type;
  final String contentType;
  final String objectId;
  final String description;
  final Map<String, dynamic>? token;
  final ValueChanged<String> onError;
  final VoidCallback onSuccess;

  const CreateComplaintDonation({
    required this.type,
    required this.contentType,
    required this.objectId,
    required this.description,
    this.token,
    required this.onError,
    required this.onSuccess,
  });

  @override
  List<Object?> get props => [
        type,
        token,
        contentType,
        objectId,
        description,
      ];
}

class ReCreateBloc extends DonationsEvent {
  const ReCreateBloc();

  @override
  List<Object?> get props => [];
}

class ChangeDonationInList extends DonationsEvent {
  final DonationEntity donation;

  const ChangeDonationInList({required this.donation});

  @override
  List<Object?> get props => [];
}
