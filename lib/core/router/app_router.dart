import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healthstride/core/router/route_names.dart';
import 'package:healthstride/core/router/route_transitions.dart';
import 'package:healthstride/features/health_sync/presentation/screens/health_sync_screen.dart';
import 'package:healthstride/features/home/presentation/home_screen.dart';
import 'package:healthstride/features/splash/presentation/splash_screen.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shallNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: kDebugMode,
    initialLocation: RoutePaths.healthSync,
    routes: [
      //Splash
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        pageBuilder: (context, state) => RouteTransitions.fadeTransition(
          state: state,
          child: const SplashScreen(),
        ),
      ),

      //Home
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        pageBuilder: (context, state) => RouteTransitions.fadeTransition(
          state: state,
          child: const HomeScreen(),
        ),
      ),

      //Health Sync
      GoRoute(
        path: RoutePaths.healthSync,
        name: RouteNames.healthSync,
        pageBuilder: (context, state) => RouteTransitions.fadeTransition(
          state: state,
          child: const HealthSyncScreen(),
        ),
      ),
    ],
  );
}
