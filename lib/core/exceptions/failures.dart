import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class ServerFailure extends Failure {
  final num statusCode;
  final String errorMessage;

  ServerFailure({required this.errorMessage, required this.statusCode});
}

class DioFailure extends Failure {
 final num statusCode;
  final String errorMessage;

  DioFailure({required this.errorMessage, required this.statusCode});
}

class ParsingFailure extends Failure {
  final num statusCode;
  final String errorMessage;

  ParsingFailure({required this.errorMessage, required this.statusCode});
}

class CacheFailure extends Failure {
   final num statusCode;
  final String errorMessage;

  CacheFailure({required this.errorMessage, required this.statusCode});

}
