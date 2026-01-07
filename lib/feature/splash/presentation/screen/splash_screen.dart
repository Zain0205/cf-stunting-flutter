import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_flutter/feature/splash/presentation/provider/splash_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashProvider, (previous, next) {
      next.whenData((result) {
        if (result != null) {
          context.go(result.route, extra: result.extra);
        }
      });
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          width: 200,
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
                return const Center(
                  child: Text(
                    'Failed to load image',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              },
        ),
      ),
    );
  }
}
