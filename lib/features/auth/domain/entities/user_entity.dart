import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String fullName;
  final String username;
  final String bio;
  final String phone;
  final String email;
  final String avatar;

  const UserEntity({
    this.id = 0,
    this.bio = '',
    this.avatar = '',
    this.fullName = '',
    this.email = '',
    this.username = '',
    this.phone = '',
  });

  @override
  List<Object?> get props => [
        id,
        fullName,
        bio,
        email,
        username,
        avatar,
        phone,
      ];
}
