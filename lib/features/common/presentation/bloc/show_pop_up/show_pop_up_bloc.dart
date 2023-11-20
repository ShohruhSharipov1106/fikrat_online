import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'show_pop_up_event.dart';
part 'show_pop_up_state.dart';

class ShowPopUpBloc extends Bloc<ShowPopUpEvent, ShowPopUpState> {
  ShowPopUpBloc()
      : super(
          const ShowPopUpState(
            message: '',
            showPopUp: false,
            isSuccess: false,
          ),
        ) {
    var timer = Timer(Duration.zero, () {});
    on<ShowPopUp>((event, emit) {
      emit(
        state.copyWith(
          message: event.message,
          showPopUp: true,
          isSuccess: event.isSuccess,
        ),
      );
      if (timer.isActive) {
        timer.cancel();
      }
      timer = Timer(Duration(seconds: event.time ?? 3), () {
        add(HidePopUp());
      });
    });
    on<HidePopUp>((event, emit) {
      if (timer.isActive) {
        timer.cancel();
      }
      emit(state.copyWith(message: '', showPopUp: false));
    });
  }
}
