import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String code;
  final String session;
  final String phone;

  const LoginParams({
    this.code = '',
    this.session = '',
    this.phone = '',
  });

  @override
  List<Object?> get props => [
        code,
        session,
        phone,
      ];
}
