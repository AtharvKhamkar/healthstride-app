import 'package:flutter/material.dart';
import 'package:healthstride/services/health_service.dart';
import '../flavors.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final HealthService healthService = HealthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HealthStride')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await healthService.syncStepsData();
          },
          child: const Text('Sync Data'),
        ),
      ),
    );
  }
}
