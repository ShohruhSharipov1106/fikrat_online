import 'package:dio/dio.dart';
import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/utils/my_functions.dart';

abstract class CommonDataSource {

  Future<bool> addToFavorite({required String id});

  Future<bool> removeFromFavorite({required String id});

  Future<bool> createComplaint({
    required String type,
    required String contentType,
    required String objectId,
    required String description,
    Map<String, dynamic>? token,
  });

}

class CommonDataSourceImpl extends CommonDataSource {
  final Dio _dio;

  CommonDataSourceImpl(this._dio);

 
  @override
  Future<bool> addToFavorite({required String id}) async {
    try {
      final response = await _dio.post(
        '/$id/AddCareProjectFavourite/',
        options: Options(
            headers: StorageRepository.getString(StoreKeys.token).isEmpty
                ? {}
                : {'Authorization': StorageRepository.getString(StoreKeys.token)}),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(statusCode: e.statusCode, errorMessage: e.errorMessage);
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
  Future<bool> removeFromFavorite({required String id}) async {
    try {
      final response = await _dio.delete(
        '/announcement/AnnouncementWishlistDelete/$id',
        options: Options(
          headers: StorageRepository.getString(StoreKeys.token).isEmpty
              ? {}
              : {'Authorization': StorageRepository.getString(StoreKeys.token)},
        ),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(statusCode: e.statusCode, errorMessage: e.errorMessage);
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
  Future<bool> createComplaint({
    required String type,
    required String contentType,
    required String objectId,
    required String description,
    Map<String, dynamic>? token,
  }) async {
    Map<String, dynamic> data = {
      "type": type,
      "content_type": contentType,
      "object_id": objectId,
      "description": description,
    };
    try {
      final response = await _dio.post(
        '/ComplaintCreate/',
        data: data,
        options: Options(
          headers: token ??
              (StorageRepository.getString(StoreKeys.token).isEmpty
                  ? {}
                  : {'Authorization': StorageRepository.getString(StoreKeys.token)}),
        ),
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return true;
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage: MyFunctions.getErrorMessage(response: response.data),
        );
      }
    } on ServerException catch (e) {
      throw ServerException(statusCode: e.statusCode, errorMessage: e.errorMessage);
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
