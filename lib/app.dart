import 'package:flutter/material.dart';
import 'package:healthstride/core/router/app_router.dart';
import 'package:healthstride/core/theme/app_theme.dart';
import 'flavors.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: F.title,
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
