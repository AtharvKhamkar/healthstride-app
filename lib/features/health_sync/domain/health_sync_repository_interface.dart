import 'package:dartz/dartz.dart';
import 'package:healthstride/core/errors/failure.dart';

abstract class HealthSyncRepositoryInterface {
  Future<Either<Failure, Unit>> syncHealthData();
}
