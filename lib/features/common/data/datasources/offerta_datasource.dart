import 'package:dio/dio.dart';
import 'package:fikrat_online/core/exceptions/exceptions.dart';
import 'package:fikrat_online/core/utils/my_functions.dart';
import 'package:fikrat_online/features/common/data/models/static_page_model.dart';
import 'package:fikrat_online/features/common/domain/usecase/get_static_page_usecase.dart';
import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';

abstract class OffertaDataSource {
  Future<GenericPagination<StaticPageModel>> getStaticPage({GetStaticPageParams? params});
}

class OffertaDataSourceImpl extends OffertaDataSource {
  final Dio _dio;
  OffertaDataSourceImpl(this._dio);
  @override
  Future<GenericPagination<StaticPageModel>> getStaticPage({GetStaticPageParams? params}) async {
    Map<String, dynamic> paramaters = {};
    if (params != null) {
      if (params.source != null) {
        paramaters.putIfAbsent("source", () => params.source);
      }
      if (params.createdAtDateGte != null) {
        paramaters.putIfAbsent("created_at__date__gte", () => params.createdAtDateGte);
      }
      if (params.createdAtDateLte != null) {
        paramaters.putIfAbsent("created_at__date__lte", () => params.createdAtDateLte);
      }
      if (params.search != null) {
        paramaters.putIfAbsent("search", () => params.search);
      }
      if (params.offset != null) {
        paramaters.putIfAbsent("offset", () => params.offset);
      }
      if (params.limit != null) {
        paramaters.putIfAbsent("limit", () => params.limit);
      }
    }

    try {
      final response = await _dio.get(
        '/StaticPageList/',
        queryParameters: paramaters,
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination.fromJson(response.data, (p0) => StaticPageModel.fromJson(p0 as Map<String, dynamic>));
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
