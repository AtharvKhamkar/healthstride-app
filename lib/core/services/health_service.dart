import 'package:flutter/widgets.dart';
import 'package:health/health.dart';

class HealthService {
  final Health health = Health();

  Future<List<HealthDataPoint>> getStepData() async {
    try {
      final now = DateTime.now();
      final from = now.subtract(const Duration(hours: 12));
      final granted = await health.requestAuthorization(
        [HealthDataType.STEPS],
        permissions: [HealthDataAccess.READ],
      );
      if (!granted) {
        throw Exception('Health permission denied');
      }

      return await health.getHealthDataFromTypes(
        startTime: from,
        endTime: now,
        types: [HealthDataType.STEPS],
      );
    } catch (e) {
      debugPrint('ERROR :: HealthService.getStepData :: ${e.toString()}');
      rethrow;
    }
  }
}
