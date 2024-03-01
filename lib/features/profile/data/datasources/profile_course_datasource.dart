import 'package:fikrat_online/core/data/singletons/storage.dart';
import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/utils/my_functions.dart';
import 'package:fikrat_online/features/common/data/models/id_title_model.dart';
import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';
import 'package:dio/dio.dart';

abstract class ProfileCourseDataSource {
  Future<GenericPagination> getMyCourse({String? next});
}

class ProfileCourseDataSourceImpl extends ProfileCourseDataSource {
  final Dio _dio;

  ProfileCourseDataSourceImpl(this._dio);

  @override
  Future<GenericPagination> getMyCourse({String? next}) async {
    try {
      final response = await _dio.get(
        next ?? '/course/MyCoursesList',
        options: Options(
          headers: {
            'Authorization': StorageRepository.getString(StoreKeys.token)
          },
        ),
      );
      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return GenericPagination.fromJson(response.data,
            (p0) => IdTitleModel.fromJson(p0 as Map<String, dynamic>? ?? {}));
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
