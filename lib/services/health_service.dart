import 'package:health/health.dart';

class HealthService {
  final Health health = Health();

  Future<void> syncStepsData() async {
    try {
      final now = DateTime.now();
      final from = now.subtract(const Duration(hours: 1));

      final granted = await health.requestAuthorization(
        [HealthDataType.STEPS],
        permissions: [HealthDataAccess.READ],
      );

      if (!granted) {
        print('Permission denied');
        return;
      }

      final totalSteps = await health.getTotalStepsInInterval(from, now);

      print('Total Steps: $totalSteps');
    } catch (e) {
      print('Error: $e');
    }
  }
}
