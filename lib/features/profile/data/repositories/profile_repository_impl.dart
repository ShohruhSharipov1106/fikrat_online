import 'dart:async';

import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/exceptions/failures.dart';
import 'package:fikrat_online/core/utils/either.dart';
import 'package:fikrat_online/features/auth/domain/entities/authentication_status.dart';
import 'package:fikrat_online/features/auth/domain/entities/login_params.dart';
import 'package:fikrat_online/features/auth/domain/entities/user_entity.dart';
import 'package:fikrat_online/features/profile/data/datasources/profile_datasource.dart';
import 'package:fikrat_online/features/profile/domain/repositories/profile_repository.dart';
import 'package:fikrat_online/features/profile/domain/usecases/update_profile.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileDataSource profileDatasource;
  ProfileRepositoryImpl({required this.profileDatasource});
  final StreamController<AuthenticationStatus> _statusController =
      StreamController.broadcast(sync: true);
  @override
  Stream<AuthenticationStatus> statusStream() async* {
    try {
      await Future.delayed(const Duration(seconds: 2));
      await getProfile();
      yield AuthenticationStatus.authenticated;
    } on Exception {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* _statusController.stream;
  }

  @override
  Future<Either<Failure, UserEntity>> getProfile() async {
    try {
      final result = await profileDatasource.getProfile();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          statusCode: e.statusCode, errorMessage: e.errorMessage));
    } on DioExceptions catch (e) {
      return Left(
          DioFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(
      FilePathParams params) async {
    try {
      final result = await profileDatasource.updateProfile(params);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          statusCode: e.statusCode, errorMessage: e.errorMessage));
    } on DioExceptions catch (e) {
      return Left(
          DioFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> sendCodeForChangePhone(
      {required String phone}) async {
    try {
      final result =
          await profileDatasource.sendCodeForChangePhone(phone: phone);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          statusCode: e.statusCode, errorMessage: e.errorMessage));
    } on DioExceptions catch (e) {
      return Left(
          DioFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, String>> checkUserName(
      {required String userName}) async {
    try {
      final result = await profileDatasource.checkUserName(userName: userName);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          statusCode: e.statusCode, errorMessage: e.errorMessage));
    } on DioExceptions catch (e) {
      return Left(
          DioFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser({required String sha256}) async {
    try {
      final result = await profileDatasource.deleteUser(sha256: sha256);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          statusCode: e.statusCode, errorMessage: e.errorMessage));
    } on DioExceptions catch (e) {
      return Left(
          DioFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }

  @override
  Future<Either<Failure, void>> changePhone(
      {required String code,
      required String session,
      required String phone}) async {
    try {
      final result = await profileDatasource.changePhoneNumber(
          LoginParams(code: code, session: session, phone: phone));
      _statusController.add(AuthenticationStatus.authenticated);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(
          statusCode: e.statusCode, errorMessage: e.errorMessage));
    } on DioExceptions catch (e) {
      return Left(
          DioFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(
          errorMessage: e.errorMessage, statusCode: e.statusCode));
    }
  }
}
