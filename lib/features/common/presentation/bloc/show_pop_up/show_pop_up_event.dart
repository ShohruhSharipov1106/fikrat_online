part of 'show_pop_up_bloc.dart';

@immutable
abstract class ShowPopUpEvent {}

class ShowPopUp extends ShowPopUpEvent {
  final String message;
  final bool isSuccess;
  final bool isDislikeMessage;
  final int? time;
  final bool? popUpInactive;
  ShowPopUp({
    required this.message,
    this.isSuccess = false,
    this.isDislikeMessage = false,
    this.time,
    this.popUpInactive,
  });
}

class HidePopUp extends ShowPopUpEvent {}
