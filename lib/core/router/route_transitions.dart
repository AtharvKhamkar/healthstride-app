import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteTransitions {
  RouteTransitions._();

  static CustomTransitionPage<T> fadeTransition<T>({
    required GoRouterState state,
    required Widget child,
    LocalKey? key,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<T>(
      key: key ?? state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
          child: child,
        );
      },
    );
  }

  static CustomTransitionPage<T> slideTransition<T>({
    required GoRouterState state,
    required Widget child,
    LocalKey? key,
    Duration duration = const Duration(milliseconds: 300),
    SlideDirection direction = SlideDirection.rightToLeft,
  }) {
    return CustomTransitionPage<T>(
      key: key ?? state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = switch (direction) {
          SlideDirection.rightToLeft => const Offset(1.0, 0.0),
          SlideDirection.leftToRight => const Offset(-1.0, 0.0),
          SlideDirection.bottomToTop => const Offset(0.0, 1.0),
          SlideDirection.topToBottom => const Offset(0.0, -1.0),
        };

        return SlideTransition(
          position: Tween<Offset>(begin: begin, end: Offset.zero).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
    );
  }

  static CustomTransitionPage<T> slideAndFadeTransition<T>({
    required GoRouterState state,
    required Widget child,
    LocalKey? key,
    Duration duration = const Duration(milliseconds: 350),
  }) {
    return CustomTransitionPage<T>(
      key: key ?? state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0.0, 0.05),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  static CustomTransitionPage<T> scaleTransition<T>({
    required GoRouterState state,
    required Widget child,
    LocalKey? key,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<T>(
      key: key ?? state.pageKey,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
          ),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
    );
  }

  static Page<T> noTransition<T>({
    required GoRouterState state,
    required Widget child,
    LocalKey? key,
  }) {
    return NoTransitionPage<T>(key: key ?? state.pageKey, child: child);
  }
}

enum SlideDirection { rightToLeft, leftToRight, bottomToTop, topToBottom }
