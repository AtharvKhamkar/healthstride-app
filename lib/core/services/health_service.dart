import 'package:flutter/widgets.dart';
import 'package:health/health.dart';

class HealthService {
  final Health health = Health();

  ///Supported health datat types
  static const supportedHealthDataTypes = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_GLUCOSE,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.DISTANCE_DELTA,
    HealthDataType.WEIGHT,
    HealthDataType.BLOOD_OXYGEN,
  ];

  Future<List<HealthDataPoint>> getStepData() async {
    try {
      final now = DateTime.now();
      final from = now.subtract(const Duration(hours: 6));
      final granted = await health.requestAuthorization(
        supportedHealthDataTypes,
        permissions: List.generate(
          supportedHealthDataTypes.length,
          (_) => HealthDataAccess.READ,
        ),
      );
      if (!granted) {
        throw Exception('Health permission denied');
      }

      return await health.getHealthDataFromTypes(
        startTime: from,
        endTime: now,
        types: supportedHealthDataTypes,
      );
    } catch (e) {
      debugPrint('ERROR :: HealthService.getStepData :: ${e.toString()}');
      rethrow;
    }
  }
}
