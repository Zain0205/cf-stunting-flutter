import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// Helper untuk custom page transitions di GoRouter
class RouteTransitions {
  /// Cupertino transition (slide dari kanan) - mirip iOS
  static CustomTransitionPage cupertino({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return CupertinoPageTransition(
          primaryRouteAnimation: animation,
          secondaryRouteAnimation: secondaryAnimation,
          linearTransition: false,
          child: child,
        );
      },
    );
  }

  /// Fade transition
  static CustomTransitionPage fade({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  /// Slide transition dari kanan (Material style)
  static CustomTransitionPage slide({
    required Widget child,
    required GoRouterState state,
  }) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return SlideTransition(position: animation.drive(tween), child: child);
      },
    );
  }

  /// No transition (instant)
  static NoTransitionPage none({
    required Widget child,
    required GoRouterState state,
  }) {
    return NoTransitionPage(key: state.pageKey, child: child);
  }
}
