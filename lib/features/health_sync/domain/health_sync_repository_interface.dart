import 'package:dartz/dartz.dart';
import 'package:healthstride/core/errors/failure.dart';
import 'package:healthstride/shared/models/sync_health_data_request.dart';

abstract class HealthSyncRepositoryInterface {
  Future<Either<Failure, Unit>> syncHealthData({
    required SyncHealthDataRequest syncHealthDataRequest,
  });
}
