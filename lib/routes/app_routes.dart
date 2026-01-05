import 'package:go_router/go_router.dart';
import 'package:mobile_flutter/feature/auth/presentation/screen/login_screen.dart';
import 'package:mobile_flutter/feature/auth/presentation/screen/register_screen.dart';
import 'package:mobile_flutter/routes/route_path.dart';
import 'package:mobile_flutter/routes/route_transition.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: RoutePath.login,
    debugLogDiagnostics: true,
    routes: [
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
    ],
  );
}
