import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(controller: ScrollController())) {
    on<MoveToTopEvent>((event, emit) {
      if (state.controller.position.pixels > 200 - kToolbarHeight) {
        WidgetsBinding.instance.addPostFrameCallback((_) async {
          state.controller.animateTo(0, duration: const Duration(milliseconds: 300), curve: Curves.linear);
        });
      }
    });
  }
}
