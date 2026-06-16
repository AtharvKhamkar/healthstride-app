import 'package:dartz/dartz.dart';
import 'package:healthstride/core/errors/failure.dart';
import 'package:healthstride/features/health_sync/data/health_sync_api.dart';
import 'package:healthstride/features/health_sync/domain/health_sync_repository_interface.dart';
import 'package:healthstride/shared/models/sync_health_data_request.dart';

class HealthSyncRepository implements HealthSyncRepositoryInterface {
  final HealthSyncApi _healthSyncApi;

  HealthSyncRepository({required HealthSyncApi healthSyncApi})
    : _healthSyncApi = healthSyncApi;

  @override
  Future<Either<Failure, Unit>> syncHealthData({
    required SyncHealthDataRequest syncHealthDataRequest,
  }) async {
    try {
      final response = await _healthSyncApi.syncHealthData(
        syncHealthDataRequest: syncHealthDataRequest,
      );

      return response.fold(
        (Failure failure) => Left(failure),
        (Map<String, dynamic> data) => Right(unit),
      );
    } catch (e) {
      return Left(
        ServerFailure(
          'Something went wrong. Please try again or contact support if the issue persists',
        ),
      );
    }
  }
}
