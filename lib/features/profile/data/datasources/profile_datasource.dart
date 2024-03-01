import 'dart:developer';

import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/utils/my_functions.dart';
import 'package:fikrat_online/features/auth/data/models/error_status.dart';
import 'package:fikrat_online/features/auth/data/models/user_model.dart';
import 'package:fikrat_online/features/auth/domain/entities/login_params.dart';
import 'package:fikrat_online/features/profile/domain/usecases/update_profile.dart';
import 'package:dio/dio.dart';

abstract class ProfileDataSource {
  Future<UserModel> getProfile();
  Future<String> sendCodeForChangePhone({required String phone});
  Future<String> checkUserName({required String userName});
  Future<void> deleteUser({required String sha256});
  Future<UserModel> updateProfile(FilePathParams params);
  Future<void> changePhoneNumber(LoginParams params);
}

class ProfileDataSourceImpl extends ProfileDataSource {
  final Dio _dio;

  ProfileDataSourceImpl(this._dio);

  @override
  Future<UserModel> getProfile() async {
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
          statusCode: e.statusCode, errorMessage: e.errorMessage);
    } on DioExceptions catch (e) {
      throw DioExceptions(errorMessage: e.toString(), statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
    }
  }

  @override
  Future<void> changePhoneNumber(LoginParams params) async {
    try {
      final response = await _dio.post('/users/UserChangePhone',
          options: Options(headers: {
            'Authorization': StorageRepository.getString(StoreKeys.token)
          }),
          data: {
            "code": params.code,
            "session": params.session,
            "phone": params.phone,
          });
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
          statusCode: e.statusCode, errorMessage: e.errorMessage);
    } on DioExceptions catch (e) {
      throw DioExceptions(errorMessage: e.toString(), statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
    }
  }

  @override
  Future<String> checkUserName({required String userName}) async {
    try {
      final response = await _dio.post('/users/CheckUsername',
          // options: Options(headers: {'Authorization': 'Bearer ${StorageRepository.getString('access')}'}),
          data: {
            "username": userName,
          });
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return response.data['success'] as String;
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
          statusCode: e.statusCode, errorMessage: e.errorMessage);
    } on DioExceptions catch (e) {
      throw DioExceptions(errorMessage: e.toString(), statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
    }
  }

  @override
  Future<String> sendCodeForChangePhone({required String phone}) async {
    try {
      final response = await _dio.post('/users/SendCodeForChangePhone',
          options: Options(headers: {
            'Authorization': StorageRepository.getString(StoreKeys.token)
          }),
          data: {
            "phone": phone,
          });
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return response.data['session'] as String;
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
          statusCode: e.statusCode, errorMessage: e.errorMessage);
    } on DioExceptions catch (e) {
      throw DioExceptions(errorMessage: e.toString(), statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
    }
  }

  @override
  Future<UserModel> updateProfile(FilePathParams params) async {
    try {
      var mapData = <String, dynamic>{
        // "username": params.userName,
        // "full_name": params.fullName,
        // "bio": params.bio,
        // "email": params.email,
      };
      if (params.fullName != null) {
        if (params.fullName!.isEmpty) {
          mapData.putIfAbsent('full_name', () => null);
        } else {
          mapData.putIfAbsent('full_name', () => params.fullName);
        }
      }
      if (params.userName != null) {
        if (params.userName!.isEmpty) {
          mapData.putIfAbsent('username', () => null);
        } else {
          mapData.putIfAbsent('username', () => params.userName);
        }
      }
      if (params.bio != null) {
        if (params.bio!.isEmpty) {
          mapData.putIfAbsent('bio', () => null);
        } else {
          mapData.putIfAbsent('bio', () => params.bio);
        }
      }
      if (params.email != null) {
        if (params.email!.isEmpty) {
          mapData.putIfAbsent('email', () => null);
        } else {
          mapData.putIfAbsent('email', () => params.email);
        }
      }
      try {
        if (params.imagePath != null && params.imagePath!.isNotEmpty) {
          if (params.imagePath == 'del') {
            mapData.putIfAbsent('avatar', () => null);
          } else {
            final image = await MultipartFile.fromFile(params.imagePath!,
                filename: params.imagePath!.split('/').last);
            mapData.putIfAbsent('avatar', () => image);
          }
        }
      } catch (e) {}

      // final List<MultipartFile> value = [image];
      // final List<String> key = ['avatar'];
      // int i = -1;
      // mapData.addEntries(value.map((e) {
      //   i++;
      //   return MapEntry(key[i], e);
      // }));
      // print('email => ${mapData['email']}');
      // print('bio => ${mapData['bio']}');
      // print('full name => ${mapData['full_name']}');
      // print('user name => ${mapData['username']}');
      final response = await _dio.patch('/users/UpdateProfile',
          data: params.imagePath != null &&
                  params.imagePath!.isNotEmpty &&
                  params.imagePath != 'del'
              ? FormData.fromMap(mapData)
              : mapData,
          options: Options(headers: {
            'Authorization': StorageRepository.getString(StoreKeys.token)
          }));
      log('update profile 1 => ${response.realUri} $mapData ${params.imagePath}');
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
          statusCode: e.statusCode, errorMessage: e.errorMessage);
    } on DioExceptions catch (e) {
      throw DioExceptions(errorMessage: e.toString(), statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
    }
  }

  @override
  Future<void> deleteUser({required String sha256}) async {
    try {
      final response = await _dio.delete('/users/DeleteProfile',
          options: Options(headers: {
            'Authorization': StorageRepository.getString(StoreKeys.token),
            'hashed-secret': sha256,
          }));
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
          statusCode: e.statusCode, errorMessage: e.errorMessage);
    } on DioExceptions catch (e) {
      throw DioExceptions(errorMessage: e.toString(), statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ParsingException(
        statusCode: 422,
        errorMessage: MyFunctions.getErrorMessage(response: e.toString()),
      );
    }
  }
}
