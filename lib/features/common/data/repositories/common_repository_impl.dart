// import 'package:fikrat_online/core/exceptions/exceptions.dart';
// import 'package:fikrat_online/core/exceptions/failures.dart';
// import 'package:fikrat_online/core/utils/either.dart';
// import 'package:fikrat_online/features/common/data/datasources/common_datasources.dart';
// import 'package:fikrat_online/features/common/domain/entities/choices_entity.dart';
// import 'package:fikrat_online/features/common/domain/entities/complaint_entity.dart';
// import 'package:fikrat_online/features/common/domain/repositories/common_repository.dart';
// import 'package:fikrat_online/features/common/domain/usecase/get_complaint_types_usecase.dart';
// import 'package:fikrat_online/features/pagination/data/models/generic_pagination.dart';
// import 'package:fikrat_online/features/region/domain/use_cases/get_regions_usecase.dart';
//
// class CommonRepositoryImpl extends CommonRepository {
//   CommonDataSource dataSource;
//
//   CommonRepositoryImpl({required this.dataSource});
//
//   @override
//   Future<Either<Failure, bool>> addToFavotire(String id) async {
//     try {
//       var result = await dataSource.addToFavorite(id: id);
//       return Right(result);
//     } on DioExceptions {
//       return Left(DioFailure());
//     } on ParsingException catch (e) {
//       return Left(ParsingFailure(errorMessage: e.errorMessage));
//     } on ServerException catch (e) {
//       return Left(ServerFailure(
//           errorMessage: e.errorMessage, statusCode: e.statusCode));
//     }
//   }
//
//   @override
//   Future<Either<Failure, bool>> removeFromFavotire(String id) async {
//     try {
//       var result = await dataSource.removeFromFavorite(id: id);
//       return Right(result);
//     } on DioExceptions {
//       return Left(DioFailure());
//     } on ParsingException catch (e) {
//       return Left(ParsingFailure(errorMessage: e.errorMessage));
//     } on ServerException catch (e) {
//       return Left(ServerFailure(
//           errorMessage: e.errorMessage, statusCode: e.statusCode));
//     }
//   }
//
//   @override
//   Future<Either<Failure, bool>> createComplaint({
//     required String type,
//     required String contentType,
//     required String objectId,
//     required String description,
//     Map<String, dynamic>? token,
//   }) async {
//     try {
//       var result = await dataSource.createComplaint(
//         type: type,
//         contentType: contentType,
//         description: description,
//         objectId: objectId,
//         token: token,
//       );
//       return Right(result);
//     } on DioExceptions {
//       return Left(DioFailure());
//     } on ParsingException catch (e) {
//       return Left(ParsingFailure(errorMessage: e.errorMessage));
//     } on ServerException catch (e) {
//       return Left(ServerFailure(
//           errorMessage: e.errorMessage, statusCode: e.statusCode));
//     }
//   }
//
//   @override
//   Future<Either<Failure, GenericPagination<ComplaintEntity>>> getComplaintTypes(
//       {required GetComplaintTypesParams params}) async {
//     try {
//       var result = await dataSource.getComplaintTypesList(params: params);
//       return Right(result);
//     } on DioExceptions {
//       return Left(DioFailure());
//     } on ParsingException catch (e) {
//       return Left(ParsingFailure(errorMessage: e.errorMessage));
//     } on ServerException catch (e) {
//       return Left(ServerFailure(
//           errorMessage: e.errorMessage, statusCode: e.statusCode));
//     }
//   }
//
//   @override
//   Future<Either<Failure, ChoicesEntity>> getFondTypes(
//       {GetRegionParams? params}) async {
//     try {
//       final result = await dataSource.getFondTypes(params: params);
//       return Right(result);
//     } on DioExceptions {
//       return Left(DioFailure());
//     } on ParsingException catch (e) {
//       return Left(ParsingFailure(errorMessage: e.errorMessage));
//     } on ServerException catch (e) {
//       return Left(ServerFailure(
//           errorMessage: e.errorMessage, statusCode: e.statusCode));
//     }
//   }
// }
