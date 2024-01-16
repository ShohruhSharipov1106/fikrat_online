part of 'login_sign_up_bloc.dart';

@immutable
abstract class LoginSignUpEvent {}

class LoginConfirmEvent extends LoginSignUpEvent {
  final Function(String message) onError;
  final Function onSuccess;
  final String code;

  LoginConfirmEvent({
    required this.onError,
    required this.onSuccess,
    required this.code,
  });
}

class SubmitPhone extends LoginSignUpEvent {
  final String phone;
  final Function(String message) onError;
  final Function onSuccess;
  SubmitPhone({
    required this.phone,
    required this.onError,
    required this.onSuccess,
  });
}

class SetTimer extends LoginSignUpEvent {
  final int secondsLeft;
  SetTimer({required this.secondsLeft});
}

class FocusTextField extends LoginSignUpEvent {
  final bool isFocus;

  FocusTextField({
    required this.isFocus,
  });
}
