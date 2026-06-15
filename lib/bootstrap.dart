import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health/health.dart';
import 'package:healthstride/core/config/firebase_config.dart';
import 'app.dart';
import 'flavors.dart';

Future<void> bootstrap(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  F.appFlavor = flavor;

  await Firebase.initializeApp(
    name: F.firebaseProjectName,
    options: FirebaseConfig.options,
  );

  final health = Health();

  bool isAvailable = await health.isHealthConnectAvailable();

  runApp(const App());
}
