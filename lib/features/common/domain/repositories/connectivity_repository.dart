import 'dart:async';

class ConnectivityRepository {
  final StreamController<String> connection =
      StreamController.broadcast(sync: true);

  Stream<String> get connectionStream => connection.stream;

  void addStatus(String status) {
    connection.sink.add(status);
  }
}

class ConnectionRequestTypes {
  static const refreshList = 'refresh';
}
