part of 'authentication_bloc.dart';

class AuthenticationState {
  final AuthenticationStatus status;
  final UserEntity user;
  const AuthenticationState._({required this.status, required this.user});
  const AuthenticationState.authenticated(UserEntity user)
      : this._(status: AuthenticationStatus.authenticated, user: user);
  const AuthenticationState.unauthenticated()
      : this._(
            status: AuthenticationStatus.unauthenticated,
            user: const UserEntity());
}
