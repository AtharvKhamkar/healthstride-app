import 'package:dartz/dartz.dart';
import 'package:flutter/rendering.dart';
import 'package:healthstride/core/errors/failure.dart';
import 'package:healthstride/core/services/health_service.dart';
import 'package:healthstride/features/health_sync/data/health_sync_api.dart';
import 'package:healthstride/features/health_sync/domain/health_sync_repository_interface.dart';
import 'package:healthstride/shared/models/sync_health_data_request.dart';

class HealthSyncRepository implements HealthSyncRepositoryInterface {
  final HealthSyncApi _healthSyncApi;
  final HealthService _healthService;

  HealthSyncRepository({
    required HealthSyncApi healthSyncApi,
    required HealthService healthService,
  }) : _healthSyncApi = healthSyncApi,
       _healthService = healthService;

  @override
  Future<Either<Failure, Unit>> syncHealthData() async {
    try {
      final records = await _healthService.getStepData();
      final request = SyncHealthDataRequest(
        source: 'HEALTH_CONNECT',
        records: records,
      );
      final apiResult = await _healthSyncApi.syncHealthData(
        syncHealthDataRequest: request.toMap(),
      );

      return apiResult.fold(
        (Failure failure) => Left(failure),
        (Map<String, dynamic> _) => Right(unit),
      );
    } catch (e, stack) {
      debugPrint(
        'ERROR :: HealthSyncRepository.syncHealthData :: ${e.toString()} :: $stack',
      );
      return Left(
        ServerFailure(
          'Something went wrong. Please try again or contact support if the issue persists',
        ),
      );
    }
  }
}
