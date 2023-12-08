part of 'connectivity_bloc.dart';

class ConnectivityState extends Equatable {
  final bool connected;
  final FormzSubmissionStatus status;
  const ConnectivityState(
      {this.connected = false, this.status = FormzSubmissionStatus.initial});

  ConnectivityState copyWith({
    bool? connected,
    FormzSubmissionStatus? status,
  }) =>
      ConnectivityState(
        connected: connected ?? this.connected,
        status: status ?? this.status,
      );

  @override
  List<Object> get props => [connected, status];
}
