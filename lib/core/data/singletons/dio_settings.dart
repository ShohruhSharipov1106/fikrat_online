import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fikrat_online/assets/constants/app_constants.dart';
import 'package:fikrat_online/core/data/interceptors/token_refresh_interceptor.dart';
import 'package:fikrat_online/core/data/singletons/storage.dart';

class DioSettings {
  BaseOptions _dioBaseOptions({String? baseUrl}) => BaseOptions(
        baseUrl: baseUrl ?? AppConstants.BASE_URL_DEV,
        connectTimeout: const Duration(milliseconds: 35000),
        receiveTimeout: const Duration(milliseconds: 33000),
        followRedirects: false,
        headers: <String, dynamic>{
          'Accept-Language':
              StorageRepository.getString(StoreKeys.language, defValue: 'uz')
        },
        validateStatus: (status) => status != null && status <= 500,
      );

  void setBaseOptions({String? lang, required String baseUrl}) => BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(milliseconds: 35000),
        receiveTimeout: const Duration(milliseconds: 33000),
        headers: <String, dynamic>{'Accept-Language': lang},
        followRedirects: false,
        validateStatus: (status) => status != null && status <= 500,
      );

  Dio dio({String? baseUrl}) {
    final dio = Dio(_dioBaseOptions(baseUrl: baseUrl));
    dio.interceptors
      ..add(CustomInterceptor(dio: dio))
      ..add(
        LogInterceptor(
          responseBody: true,
          requestBody: true,
          request: true,
          requestHeader: true,
          logPrint: (object) => log(object.toString()),
        ),
      );
    return dio;
  }
}
