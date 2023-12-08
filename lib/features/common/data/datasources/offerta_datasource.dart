import 'package:dio/dio.dart';
import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/utils/my_functions.dart';

abstract class OffertaDataSource {
  Future<void> getOfferta();
}

class OffertaDataSourceImpl extends OffertaDataSource {
  final Dio _dio;
  OffertaDataSourceImpl(this._dio);
  @override
  Future<void> getOfferta() async {
    try {
      final response = await _dio.get('/StaticPageList/');
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
