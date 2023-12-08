part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent extends Equatable {
  const ConnectivityEvent();
}

class SetupConnectivity extends ConnectivityEvent {
  const SetupConnectivity();

  @override
  List<Object> get props => [];
}

class ChangeStatus extends ConnectivityEvent {
  const ChangeStatus(this.status);
  final bool status;

  @override
  List<Object> get props => [status];
}

class CheckConnection extends ConnectivityEvent {
  const CheckConnection({this.onSuccess});
  final VoidCallback? onSuccess;

  @override
  List<Object?> get props => [onSuccess];
}
