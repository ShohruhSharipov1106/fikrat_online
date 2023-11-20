import 'dart:ui';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:imkon_care/features/common/domain/repositories/connectivity_repository.dart';

part 'connectivity_bloc.freezed.dart';
part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity connectivity = Connectivity();
  final ConnectivityRepository repo;

  ConnectivityBloc(this.repo) : super(const ConnectivityState()) {
    connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        repo.addStatus(ConnectionRequestTypes.refreshList);
        add(const ConnectivityEvent.changeStatus(true));
      } else {
        add(const ConnectivityEvent.changeStatus(false));
      }
    });
    on<_ChangeStatus>((event, emit) {
      emit(state.copyWith(connected: event.status));
    });
    on<_Setup>((event, emit) {});
    on<_CheckConnection>((event, emit) async {
      final checkConnection = await connectivity.checkConnectivity();
      if (checkConnection == ConnectivityResult.mobile || checkConnection == ConnectivityResult.wifi) {
        repo.addStatus(ConnectionRequestTypes.refreshList);
        add(const ConnectivityEvent.changeStatus(true));
      } else {
        add(const ConnectivityEvent.changeStatus(false));
      }
    });
  }
}
