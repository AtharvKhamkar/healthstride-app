import 'package:dartz/dartz.dart';
import 'package:healthstride/core/constants/api_constant.dart';
import 'package:healthstride/core/errors/failure.dart';
import 'package:healthstride/core/network/api_client.dart';

class HealthSyncApi {
  final ApiClient _apiClient;

  HealthSyncApi({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<Either<Failure, Map<String, dynamic>>> syncHealthData({
    required Map<String,dynamic> syncHealthDataRequest,
  }) async {
    final response = await _apiClient.post(
      ApiEndpoints.syncHealthData,
      data: syncHealthDataRequest,
    );

    return response.fold(
      (String message) => Left(ServerFailure(message)),
      (Map<String, dynamic> data) => Right(data),
    );
  }
}
