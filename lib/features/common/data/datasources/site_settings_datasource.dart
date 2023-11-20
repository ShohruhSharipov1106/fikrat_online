import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/utils/my_functions.dart';
import 'package:fikrat_online/features/common/data/models/about_model.dart';
import 'package:fikrat_online/features/common/data/models/service_status_model.dart';
import 'package:fikrat_online/features/common/data/models/site_settings_model.dart';
import 'package:dio/dio.dart';

abstract class SiteSettingsDataSource {
  Future<SiteSettingsModel> getSiteSettings();
  Future<AboutModel> getAboutInformation();
  Future<ServiceStatusModel> getServiceStatus();
}

class SiteSettingsDataSourceImpl extends SiteSettingsDataSource {
  final Dio _dio;
  SiteSettingsDataSourceImpl(this._dio);

  @override
  Future<SiteSettingsModel> getSiteSettings() async {
    try {
      final response = await _dio.get('/common/SiteSettings');
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return SiteSettingsModel.fromJson(response.data);
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
        statusCode: e.statusCode,
        errorMessage: e.errorMessage,
      );
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
  Future<AboutModel> getAboutInformation() async {
    try {
      final response = await _dio.get('/CareContact/');
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return AboutModel.fromJson(response.data);
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
        statusCode: e.statusCode,
        errorMessage: e.errorMessage,
      );
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
  Future<ServiceStatusModel> getServiceStatus() async {
    try {
      final response = await _dio.get('/common/ServiceStatus');
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return ServiceStatusModel.fromJson(response.data);
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(
        statusCode: e.statusCode,
        errorMessage: e.errorMessage,
      );
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
