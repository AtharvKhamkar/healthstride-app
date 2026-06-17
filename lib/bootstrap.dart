import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthstride/core/config/firebase_config.dart';
import 'package:healthstride/core/network/api_client.dart';
import 'package:healthstride/core/services/bloc_observer_service.dart';
import 'package:healthstride/core/services/health_service.dart';
import 'package:healthstride/core/storage/secure_storage.dart';
import 'package:healthstride/features/health_sync/data/health_sync_api.dart';
import 'package:healthstride/features/health_sync/data/health_sync_repository.dart';
import 'package:healthstride/features/health_sync/domain/health_sync_repository_interface.dart';
import 'package:healthstride/features/health_sync/presentation/bloc/health_sync_bloc.dart';
import 'app.dart';
import 'flavors.dart';

Future<void> bootstrap(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();

  ///initialize flavors
  F.appFlavor = flavor;

  ///initialize firebase
  await Firebase.initializeApp(
    name: F.firebaseProjectName,
    options: FirebaseConfig.options,
  );

  // final health = Health();

  // bool isAvailable = await health.isHealthConnectAvailable();

  ///Initialize core services
  final SecureStorage secureStorage = SecureStorage();
  final HealthService healthService = HealthService();

  ///Initialize repository interfaces
  final HealthSyncRepositoryInterface healthSyncRepository;

  ///Initialize api client
  final apiClient = ApiClient(secureStorage: secureStorage);

  ///Initialize api classes
  final HealthSyncApi healthSyncApi = HealthSyncApi(apiClient: apiClient);

  ///assign repository classes
  healthSyncRepository = HealthSyncRepository(
    healthSyncApi: healthSyncApi,
    healthService: healthService,
  );

  Bloc.observer = BlocObserverService();

  runApp(
    MultiRepositoryProvider(
      providers: [RepositoryProvider<ApiClient>.value(value: apiClient)],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<HealthSyncBloc>(
            create: (_) =>
                HealthSyncBloc(healthSyncRepository: healthSyncRepository),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
