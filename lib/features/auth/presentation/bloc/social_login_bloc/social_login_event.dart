part of 'social_login_bloc.dart';

@immutable
abstract class SocialLoginEvent {}

class LoginWithGoogle extends SocialLoginEvent {
  final ValueChanged<String> onError;

  LoginWithGoogle({required this.onError});
}

class LoginWithApple extends SocialLoginEvent {
  final ValueChanged<String> onError;

  LoginWithApple({required this.onError});
}
