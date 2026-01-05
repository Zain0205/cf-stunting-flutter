import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/routes/app_routes.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => ProviderScope(
        overrides: [
          // storageServiceProvider.overrideWith((ref) async => storageService),
          // storageServiceSyncProvider.overrideWithValue(storageService),
        ],
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "CF",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: AppRoutes.router,
      builder: DevicePreview.appBuilder,
      locale: DevicePreview.locale(context) ?? const Locale('id', 'ID'),
      supportedLocales: [const Locale('id', 'ID'), const Locale('en', 'US')],
    );
  }
}
