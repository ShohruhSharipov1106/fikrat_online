part of 'social_login_bloc.dart';

@immutable
abstract class SocialLoginState {}

class SocialLoginInitial extends SocialLoginState {}

class SocialLoginLoading extends SocialLoginState {}

class SocialLoginSuccess extends SocialLoginState {}

class SocialLoginFailure extends SocialLoginState {}
