import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/utils/my_functions.dart';
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
    try {
      final response =
          await _dio.post('/users/SendAuthVerificationCode', data: {
        "phone": phone,
      });
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return '';
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
          statusCode: e.statusCode,
          errorMessage: MyFunctions.getErrorMessage(response: e.errorMessage));
    } on DioException catch (e) {
      throw DioExceptions(
          statusCode: e.response?.statusCode ?? 400,
          errorMessage:
              MyFunctions.getErrorMessage(response: e.response?.data));
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
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
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
          statusCode: e.statusCode,
          errorMessage: MyFunctions.getErrorMessage(response: e.errorMessage));
    } on DioException catch (e) {
      throw DioExceptions(
          statusCode: e.response?.statusCode ?? 400,
          errorMessage:
              MyFunctions.getErrorMessage(response: e.response?.data));
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
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
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
          statusCode: e.statusCode,
          errorMessage: MyFunctions.getErrorMessage(response: e.errorMessage));
    } on DioException catch (e) {
      throw DioExceptions(
          statusCode: e.response?.statusCode ?? 400,
          errorMessage:
              MyFunctions.getErrorMessage(response: e.response?.data));
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
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
    } on ServerException catch (e) {
      throw ServerException(
          statusCode: e.statusCode,
          errorMessage: MyFunctions.getErrorMessage(response: e.errorMessage));
    } on DioException catch (e) {
      throw DioExceptions(
          statusCode: e.response?.statusCode ?? 400,
          errorMessage:
              MyFunctions.getErrorMessage(response: e.response?.data));
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
    }
  }
}
