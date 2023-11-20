import 'package:dio/dio.dart';

class CustomInterceptor implements Interceptor {
  final Dio dio;

  const CustomInterceptor({required this.dio});

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403 || err.response?.statusCode == 401) {
      StorageRepository.deleteString(StoreKeys.token);
      print("token refresh on error");
      await _refreshToken();
      if (StorageRepository.getString(StoreKeys.token).replaceAll('Bearer', '').trim().isNotEmpty) {
        err.requestOptions.headers['Authorization'] = StorageRepository.getString(StoreKeys.token);
      }

      final response = await _resolveResponse(err.requestOptions);
      handler.resolve(response);
      return;
    }
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    handler.next(options);
  }

  @override
  Future<void> onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (response.statusCode == 403) {
      if (StorageRepository.getString(StoreKeys.refresh).isEmpty) {
        handler.next(response);
        print("token refresh on response");
        await _refreshToken();
        return;
      }

      if (StorageRepository.getString(StoreKeys.token).replaceAll('Bearer', '').trim().isNotEmpty) {
        response.requestOptions.headers['Authorization'] = StorageRepository.getString(StoreKeys.token);
      }
      final resolved = await _resolveResponse(response.requestOptions);
      handler.resolve(resolved);
      return;
    }
    handler.next(response);
  }

  Future<void> _refreshToken() async {
    if (StorageRepository.getString(StoreKeys.refresh).isNotEmpty) {
      final response = await dio.post('${AppConstants.idUrl}/TokenRefresh/',
          data: {"refresh": StorageRepository.getString(StoreKeys.refresh)});
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        StorageRepository.putString(StoreKeys.token, 'Bearer ${response.data['access']}');
      } else {
        StorageRepository.deleteString(StoreKeys.refresh);
      }
    }
  }

  Future<Response<dynamic>> _resolveResponse(RequestOptions options) async {
    if (options.data is FormData) {
      FormData formData = FormData();
      final fields = options.data.fields as List<MapEntry<String, String>>;
      formData.fields.addAll(fields);

      for (MapEntry mapFile in options.data.files) {
        formData.files.add(MapEntry(
            mapFile.key,
            MultipartFile.fromFileSync(
                fields.firstWhere((element) => element.key == 'photo_path', orElse: () => const MapEntry('', '')).value,
                filename: mapFile.value.filename)));
      }
      options.data = formData;
    }
    return await dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: Options(
        headers: options.headers,
        method: options.method,
      ),
    );
  }
}