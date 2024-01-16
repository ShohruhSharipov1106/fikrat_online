part of 'login_sign_up_bloc.dart';

class LoginSignUpState extends Equatable {
  final FormzSubmissionStatus loginStatus;
  final FormzSubmissionStatus submitCodeStatus;
  final String session;
  final bool isFocus;
  final String phone;
  const LoginSignUpState({
    required this.loginStatus,
    required this.submitCodeStatus,
    required this.phone,
    required this.isFocus,
    required this.session,
  });

  const LoginSignUpState.empty([
    this.loginStatus = FormzSubmissionStatus.initial,
    this.submitCodeStatus = FormzSubmissionStatus.initial,
    this.isFocus = false,
    this.session = '',
    this.phone = '',
  ]);
  LoginSignUpState copyWith({
    FormzSubmissionStatus? loginStatus,
    FormzSubmissionStatus? submitCodeStatus,
    String? phone,
    String? session,
    int? secondsLeft,
    bool? isFocus,
  }) =>
      LoginSignUpState(
        loginStatus: loginStatus ?? this.loginStatus,
        submitCodeStatus: submitCodeStatus ?? this.submitCodeStatus,
        phone: phone ?? this.phone,
        session: session ?? this.session,
        isFocus: isFocus ?? this.isFocus,
      );

  @override
  List<Object?> get props => [
        loginStatus,
        submitCodeStatus,
        phone,
        isFocus,
        session,
      ];
}
