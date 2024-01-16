import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/features/auth/data/models/error_status.dart';
import 'package:fikrat_online/features/auth/data/models/user_model.dart';
import 'package:fikrat_online/features/auth/domain/entities/login_params.dart';
import 'package:fikrat_online/features/auth/domain/entities/social_network_type.dart';
import 'package:dio/dio.dart';

abstract class AuthenticationDataSource {
  Future<void> getLogin(LoginParams params);
  Future<UserModel> getUserData();
  Future<String> submitPhone({required String phone});
  Future<void> loginWithSocialNet(
      {required SocialNetworkType socialNetworkType,
      required String? accessToken,
      required String code});
}

class AuthenticationDataSourceImpl extends AuthenticationDataSource {
  final Dio _dio;

  AuthenticationDataSourceImpl(this._dio);

  @override
  Future<String> submitPhone({required String phone}) async {
    if (phone.isNotEmpty) {
      try {
        final response =
            await _dio.post('/users/SendAuthVerificationCode', data: {
          "phone": phone,
        });
        if (response.statusCode != null &&
            response.statusCode! >= 200 &&
            response.statusCode! < 300) {
          return response.data['session'] as String;
        } else {
          if (response.data is Map) {
            final errorMessage = ErrorStatusModel.fromJson(response.data);
            if (errorMessage.errors.isNotEmpty) {
              throw ServerException(
                errorMessage: errorMessage.errors.first.message,
                statusCode: response.statusCode!,
              );
            } else {
              throw ServerException(
                errorMessage: response.data['errors'][0]['message'].toString(),
                statusCode: response.statusCode!,
              );
            }
          } else {
            if (response.data is Map) {
              throw ServerException(
                  statusCode: response.statusCode!,
                  errorMessage:
                      response.data['errors'][0]['message'].toString());
            } else {
              throw ServerException(
                  statusCode: response.statusCode!,
                  errorMessage:
                      response.data['errors'][0]['message'].toString());
            }
          }
        }
      } on ServerException {
        rethrow;
      } on DioException {
        throw DioExceptions();
      } on Exception catch (e) {
        throw ParsingException(errorMessage: e.toString());
      }
    } else {
      throw const ParsingException(
          errorMessage: 'LocaleKeys.phone_number_cannot_be_empty');
    }
  }

  @override
  Future<UserModel> getUserData() async {
    try {
      final response = await _dio.get('/users/GetProfile',
          options: Options(headers: {
            'Authorization': StorageRepository.getString(StoreKeys.token)
          }));
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return UserModel.fromJson(response.data);
      } else {
        if (response.data is Map) {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: ((response.data as Map).values.isNotEmpty
                      ? (response.data as Map).values.first
                      : 'LocaleKeys.error_while_get_user')
                  .toString());
        } else {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: response.data['errors'][0]['message'].toString());
        }
      }
    } on ServerException {
      rethrow;
    } on DioException {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> getLogin(LoginParams params) async {
    try {
      final response = await _dio.post('/users/Login', data: {
        "code": params.code,
        "session": params.session,
        "phone": params.phone,
      });
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        await StorageRepository.putString(
            StoreKeys.token, "Bearer ${response.data['access']}");
        await StorageRepository.putString(
            StoreKeys.refresh, "${response.data['refresh']}");
      } else {
        if (response.data is Map) {
          throw ServerException(
              statusCode: response.statusCode!,
              errorMessage: ((response.data as Map).values.isNotEmpty
                      ? (response.data as Map).values.first
                      : 'LocaleKeys.phone_number_error')
                  .toString());
        } else {
          if (response.data is Map) {
            throw ServerException(
                statusCode: response.statusCode!,
                errorMessage: ((response.data as Map).values.isNotEmpty
                        ? (response.data as Map).values.first
                        : '')
                    .toString());
          } else {
            throw ServerException(
                statusCode: response.statusCode!,
                errorMessage: response.data['errors'][0]['message'].toString());
          }
        }
      }
    } on ServerException {
      rethrow;
    } on DioException {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  @override
  Future<void> loginWithSocialNet(
      {required SocialNetworkType socialNetworkType,
      required String? accessToken,
      required String code}) async {
    try {
      String endPoint = '';
      switch (socialNetworkType) {
        case SocialNetworkType.facebook:
          endPoint = 'users/social-auth/login/facebook/';
          break;
        case SocialNetworkType.apple:
          endPoint = '/social-auth/AppleLogin';
          break;
        case SocialNetworkType.google:
          endPoint = '/social-auth/GoogleLogin';
          break;
      }
      final data = {"code": code};
      if (accessToken != null) {
        data.putIfAbsent('access_token', () => accessToken);
      }
      final response = await _dio.post(endPoint, data: data);
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        await StorageRepository.putString(
            StoreKeys.token, "Bearer ${response.data['access_token']}");
        await StorageRepository.putString(
            StoreKeys.refresh, "${response.data['refresh_token']}");
      } else if (response.statusCode != null &&
          response.statusCode! >= 400 &&
          response.statusCode! < 500) {
        if (response.data is Map) {
          final errorMessage = ErrorStatusModel.fromJson(response.data);
          if (errorMessage.errors.isNotEmpty) {
            throw ServerException(
              errorMessage: errorMessage.errors.first.message,
              statusCode: response.statusCode!,
            );
          } else {
            throw ServerException(
              errorMessage: response.data['errors'][0]['message'].toString(),
              statusCode: response.statusCode!,
            );
          }
        }
      } else {
        throw ServerException(
            statusCode: response.statusCode!,
            errorMessage: response.data.toString());
      }
    } on ServerException {
      rethrow;
    } on DioException {
      throw DioExceptions();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
