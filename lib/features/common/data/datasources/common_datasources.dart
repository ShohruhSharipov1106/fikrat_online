// import 'package:dio/dio.dart';
// import 'package:fikrat_online/core/data/singletons/storage.dart';
// import 'package:fikrat_online/core/exceptions/exceptions.dart';
// import 'package:fikrat_online/core/utils/my_functions.dart';
// import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';
//
// abstract class CommonDataSource {
//   Future<ChoicesModel> getFondTypes({GetRegionParams? params});
//
//   Future<bool> addToFavorite({required String id});
//
//   Future<bool> removeFromFavorite({required String id});
//
//   Future<bool> createComplaint({
//     required String type,
//     required String contentType,
//     required String objectId,
//     required String description,
//     Map<String, dynamic>? token,
//   });
//
//   Future<GenericPagination<ComplaintModel>> getComplaintTypesList(
//       {required GetComplaintTypesParams params});
// }
//
// class CommonDataSourceImpl extends CommonDataSource {
//   final Dio _dio;
//
//   CommonDataSourceImpl(this._dio);
//
//   @override
//   Future<ChoicesModel> getFondTypes({GetRegionParams? params}) async {
//     Map<String, dynamic> paramaters = {};
//     if (params != null) {
//       if (params.search != null) {
//         paramaters.putIfAbsent("search", () => params.search);
//       }
//       if (params.parent != null) {
//         paramaters.putIfAbsent("parent", () => params.parent);
//       }
//       if (params.parentIsNull != null) {
//         paramaters.putIfAbsent("parent__isnull", () => params.parentIsNull);
//       }
//     }
//     try {
//       final response = await _dio.get(
//         params?.next ?? "/CompanyTypeList/",
//         options: Options(
//           headers: StorageRepository.getString(StoreKeys.token).isEmpty
//               ? {}
//               : {'Authorization': StorageRepository.getString(StoreKeys.token)},
//         ),
//         queryParameters: paramaters,
//       );
//       if (response.statusCode != null &&
//           response.statusCode! >= 200 &&
//           response.statusCode! < 300) {
//         return ChoicesModel.fromJson(response.data);
//       } else {
//         throw ServerException(
//           statusCode: response.statusCode ?? 400,
//           errorMessage: MyFunctions.getErrorMessage(response: response.data),
//         );
//       }
//     } on ServerException catch (e) {
//       throw ServerException(
//           statusCode: e.statusCode, errorMessage: e.errorMessage);
//     } on DioException {
//       throw DioExceptions();
//     } on Exception catch (e) {
//       throw ParsingException(errorMessage: e.toString());
//     }
//   }
//
//   @override
//   Future<bool> addToFavorite({required String id}) async {
//     try {
//       final response = await _dio.post(
//         '/$id/AddCareProjectFavourite/',
//         options: Options(
//             headers: StorageRepository.getString(StoreKeys.token).isEmpty
//                 ? {}
//                 : {
//                     'Authorization':
//                         StorageRepository.getString(StoreKeys.token)
//                   }),
//       );
//       if (response.statusCode != null &&
//           response.statusCode! >= 200 &&
//           response.statusCode! < 300) {
//         return true;
//       } else {
//         throw ServerException(
//           statusCode: response.statusCode ?? 400,
//           errorMessage: MyFunctions.getErrorMessage(response: response.data),
//         );
//       }
//     } on ServerException catch (e) {
//       throw ServerException(
//           statusCode: e.statusCode, errorMessage: e.errorMessage);
//     } on DioException {
//       throw DioExceptions();
//     } on Exception catch (e) {
//       throw ParsingException(errorMessage: e.toString());
//     }
//   }
//
//   @override
//   Future<bool> removeFromFavorite({required String id}) async {
//     try {
//       final response = await _dio.delete(
//         '/announcement/AnnouncementWishlistDelete/$id',
//         options: Options(
//           headers: StorageRepository.getString(StoreKeys.token).isEmpty
//               ? {}
//               : {'Authorization': StorageRepository.getString(StoreKeys.token)},
//         ),
//       );
//       if (response.statusCode != null &&
//           response.statusCode! >= 200 &&
//           response.statusCode! < 300) {
//         return true;
//       } else {
//         throw ServerException(
//           statusCode: response.statusCode ?? 400,
//           errorMessage: MyFunctions.getErrorMessage(response: response.data),
//         );
//       }
//     } on ServerException catch (e) {
//       throw ServerException(
//           statusCode: e.statusCode, errorMessage: e.errorMessage);
//     } on DioException {
//       throw DioExceptions();
//     } on Exception catch (e) {
//       throw ParsingException(errorMessage: e.toString());
//     }
//   }
//
//   @override
//   Future<bool> createComplaint({
//     required String type,
//     required String contentType,
//     required String objectId,
//     required String description,
//     Map<String, dynamic>? token,
//   }) async {
//     Map<String, dynamic> data = {
//       "type": type,
//       "content_type": contentType,
//       "object_id": objectId,
//       "description": description,
//     };
//     try {
//       final response = await _dio.post(
//         '/ComplaintCreate/',
//         data: data,
//         options: Options(
//           headers: token ??
//               (StorageRepository.getString(StoreKeys.token).isEmpty
//                   ? {}
//                   : {
//                       'Authorization':
//                           StorageRepository.getString(StoreKeys.token)
//                     }),
//         ),
//       );
//       if (response.statusCode != null &&
//           response.statusCode! >= 200 &&
//           response.statusCode! < 300) {
//         return true;
//       } else {
//         throw ServerException(
//           statusCode: response.statusCode ?? 400,
//           errorMessage: MyFunctions.getErrorMessage(response: response.data),
//         );
//       }
//     } on ServerException catch (e) {
//       throw ServerException(
//           statusCode: e.statusCode, errorMessage: e.errorMessage);
//     } on DioException {
//       throw DioExceptions();
//     } on Exception catch (e) {
//       throw ParsingException(errorMessage: e.toString());
//     }
//   }
//
//   @override
//   Future<GenericPagination<ComplaintModel>> getComplaintTypesList(
//       {required GetComplaintTypesParams params}) async {
//     try {
//       final response = await _dio.get(
//         params.next ?? '/ComplaintTypeList/',
//         queryParameters: {"content_types__model": params.contentTypesModel},
//         options: Options(
//           headers: StorageRepository.getString(StoreKeys.token).isEmpty
//               ? {}
//               : {'Authorization': StorageRepository.getString(StoreKeys.token)},
//         ),
//       );
//       if (response.statusCode != null &&
//           response.statusCode! >= 200 &&
//           response.statusCode! < 300) {
//         return GenericPagination.fromJson(response.data,
//             (p0) => ComplaintModel.fromJson(p0 as Map<String, dynamic>));
//       } else {
//         throw ServerException(
//           statusCode: response.statusCode ?? 400,
//           errorMessage: MyFunctions.getErrorMessage(response: response.data),
//         );
//       }
//     } on ServerException catch (e) {
//       throw ServerException(
//           statusCode: e.statusCode, errorMessage: e.errorMessage);
//     } on DioException {
//       throw DioExceptions();
//     } on Exception catch (e) {
//       throw ParsingException(errorMessage: e.toString());
//     }
//   }
// }
