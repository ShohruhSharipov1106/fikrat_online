import 'dart:ui';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:fikrat_online/features/common/domain/repositories/connectivity_repository.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity connectivity = Connectivity();
  final ConnectivityRepository repo;

  ConnectivityBloc(this.repo) : super(const ConnectivityState()) {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        repo.addStatus(ConnectionRequestTypes.refreshList);
        add(const ChangeStatus(true));
      } else {
        add(const ChangeStatus(false));
      }
    });
    on<ChangeStatus>((event, emit) {
      emit(state.copyWith(connected: event.status));
    });
    on<SetupConnectivity>((event, emit) {});
    on<CheckConnection>((event, emit) async {
      final checkConnection = await connectivity.checkConnectivity();
      if (checkConnection == ConnectivityResult.mobile ||
          checkConnection == ConnectivityResult.wifi) {
        repo.addStatus(ConnectionRequestTypes.refreshList);
        add(const ChangeStatus(true));
      } else {
        add(const ChangeStatus(false));
      }
    });
  }
}
