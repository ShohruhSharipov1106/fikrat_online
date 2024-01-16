import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class ErrorMessageEntity extends Equatable {
  @JsonKey(name: 'error')
  final String error;
  @JsonKey(name: 'message')
  final String message;

  const ErrorMessageEntity({
    this.error = '',
    this.message = '',
  });

  @override
  List<Object?> get props => [
        error,
        message,
      ];
}
