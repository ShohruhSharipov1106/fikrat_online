import 'package:fikrat_online/features/auth/data/models/error_message.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class ErrorStatusEntity extends Equatable {
  @JsonKey(name: 'status_code')
  final int statusCode;
  @JsonKey(name: 'errors')
  final List<ErrorMessageModel> errors;

  const ErrorStatusEntity({
    this.statusCode = 0,
    this.errors = const [],
  });

  @override
  List<Object?> get props => [
        statusCode,
        errors,
      ];
}
