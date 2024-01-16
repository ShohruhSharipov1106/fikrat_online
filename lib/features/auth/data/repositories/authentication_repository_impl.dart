import 'dart:async';

import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/data/datasources/authentication_datasource.dart';
import 'package:fikrat_online/features/auth/domain/entities/authentication_status.dart';
import 'package:fikrat_online/features/auth/domain/entities/login_params.dart';
import 'package:fikrat_online/features/auth/domain/entities/social_network_type.dart';
import 'package:fikrat_online/features/auth/domain/entities/user_entity.dart';
import 'package:fikrat_online/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dio/dio.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationDataSource dataSource;

  AuthenticationRepositoryImpl({required this.dataSource});

  final StreamController<AuthenticationStatus> _statusController =
      StreamController.broadcast(sync: true);

  @override
  Stream<AuthenticationStatus> statusStream() async* {
    try {
      await Future.delayed(const Duration(seconds: 2));

      yield AuthenticationStatus.authenticated;
    } on Exception {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _statusController.stream;
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData() async =>
      await _getUserData();

  Future<Either<Failure, UserEntity>> _getUserData() async {
    try {
      final result = await dataSource.getUserData();
      return Right(result);
    } on DioException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> getLogin(
      {required String code,
      required String session,
      required String phone}) async {
    try {
      final result = await dataSource
          .getLogin(LoginParams(code: code, session: session, phone: phone));
      _statusController.add(AuthenticationStatus.authenticated);
      return Right(result);
    } on DioException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> submitPhone({required String phone}) async {
    try {
      final result = await dataSource.submitPhone(phone: phone);
      _statusController.add(AuthenticationStatus.authenticated);
      return Right(result);
    } on DioException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Stream<AuthenticationStatus> authStatusStream() async* {
    await Future.delayed(const Duration(seconds: 3));
    final result = await _getUserData();
    if (result.isRight) {
      yield AuthenticationStatus.authenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _statusController.stream;
  }

  void logOut() {
    _statusController.add(AuthenticationStatus.unauthenticated);
  }

  @override
  Future<Either<Failure, void>> loginWithSocialNet(
      {required SocialNetworkType socialNetworkType,
      required String? accessToken,
      required String code}) async {
    try {
      final result = await dataSource.loginWithSocialNet(
          socialNetworkType: socialNetworkType,
          accessToken: accessToken,
          code: code);
      _statusController.add(AuthenticationStatus.authenticated);
      return Right(result);
    } on DioException {
      return Left(DioFailure());
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }
}
