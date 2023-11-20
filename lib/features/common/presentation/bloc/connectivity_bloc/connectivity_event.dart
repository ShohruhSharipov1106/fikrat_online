part of 'connectivity_bloc.dart';

@freezed
class ConnectivityEvent with _$ConnectivityEvent {
  const factory ConnectivityEvent.setup() = _Setup;
  const factory ConnectivityEvent.changeStatus(bool status) = _ChangeStatus;
  const factory ConnectivityEvent.checkConnection({VoidCallback? onSuccess}) =
      _CheckConnection;
}
