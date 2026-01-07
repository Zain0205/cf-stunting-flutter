import 'package:go_router/go_router.dart';
import 'package:mobile_flutter/feature/auth/presentation/screen/login_screen.dart';
import 'package:mobile_flutter/feature/auth/presentation/screen/register_screen.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/domain/entity/diagnosis_history_entity.dart';
import 'package:mobile_flutter/feature/cf_diagnosis/presentation/screen/quisioner_screen.dart';
import 'package:mobile_flutter/feature/home/presentation/screen/history_detail_screen.dart';
import 'package:mobile_flutter/feature/home/presentation/screen/home_screen.dart';
import 'package:mobile_flutter/feature/onboarding/presentation/screen/onboarding_screen.dart';
import 'package:mobile_flutter/feature/splash/presentation/screen/splash_screen.dart';
import 'package:mobile_flutter/routes/route_path.dart';
import 'package:mobile_flutter/routes/route_transition.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePath.onboarding,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RoutePath.splash,
        pageBuilder: (context, state) =>
            RouteTransitions.cupertino(child: SplashScreen(), state: state),
      ),
      GoRoute(
        path: RoutePath.onboarding,
        pageBuilder: (context, state) =>
            RouteTransitions.cupertino(child: OnboardingScreen(), state: state),
      ),
      GoRoute(
        path: RoutePath.login,
        pageBuilder: (context, state) =>
            RouteTransitions.cupertino(child: LoginScreen(), state: state),
      ),
      GoRoute(
        path: RoutePath.register,
        pageBuilder: (context, state) =>
            RouteTransitions.cupertino(child: RegisterScreen(), state: state),
      ),
      GoRoute(
        path: RoutePath.mainNavigation,
        pageBuilder: (context, state) =>
            RouteTransitions.cupertino(child: HomeScreen(), state: state),
      ),
      GoRoute(
        path: RoutePath.quisioner,
        pageBuilder: (context, state) =>
            RouteTransitions.cupertino(child: QuisionerScreen(), state: state),
      ),
      GoRoute(
        path: RoutePath.historyDetail,
        pageBuilder: (context, state) {
          final detail = state.extra as DiagnosisHistoryEntity;
          return RouteTransitions.cupertino(
            child: HistoryDetailScreen(history: detail),
            state: state,
          );
        },
      ),
    ],
  );
}
