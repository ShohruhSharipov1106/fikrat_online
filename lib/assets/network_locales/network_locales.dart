// import 'package:dio/dio.dart';
// import 'package:fikrat_online/assets/constants/app_constants.dart';
// import 'package:fikrat_online/core/data/singletons/storage.dart';
// import 'package:fikrat_online/core/exceptions/exceptions.dart';
// import 'package:fikrat_online/core/utils/my_functions.dart';
//
// class NetworkLocales {
//   static Map<String, dynamic> locales = {};
//   // static String translate(String key) {
//   //   if (locales.isNotEmpty) {
//   //     if (locales.containsKey("care_mobile_$key")) {
//   //       return locales["care_mobile_$key"];
//   //     } else {
//   //       return "";
//   //     }
//   //   } else {
//   //     getLocales();
//   //     return "";
//   //   }
//   // }
//
//   static Future<void> getLocales() async {
//     try {
//       final response = await Dio(
//         BaseOptions(
//           baseUrl: AppConstants.commonUrl,
//           connectTimeout: Duration(milliseconds: 35000),
//           receiveTimeout: Duration(milliseconds: 33000),
//           followRedirects: false,
//           headers: <String, dynamic>{
//             'Accept-Language': StorageRepository.getString(StoreKeys.language, defValue: 'uz')
//           },
//           validateStatus: (status) => status != null && status <= 500,
//         ),
//       ).get("/FrontendTranslation/${StorageRepository.getString(StoreKeys.language, defValue: 'uz')}/",
//           queryParameters: {"source": "care_mobile"});
//
//       if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
//         print("response => ${response.realUri}");
//         locales = response.data as Map<String, dynamic>;
//       } else {
//         throw ServerException(
//           statusCode: response.statusCode ?? 400,
//           errorMessage: MyFunctions.getErrorMessage(response: response.data),
//         );
//       }
//     } on ServerException catch (e) {
//       throw ServerException(
//         statusCode: e.statusCode,
//         errorMessage: e.errorMessage,
//       );
//     } on DioException {
//       throw DioExceptions();
//     } on Exception catch (e) {
//       throw ParsingException(errorMessage: e.toString());
//     }
//   }
// }
