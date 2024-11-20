import 'package:flutter/foundation.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:template/core/keys/keys.dart';
import 'package:template/core/router/routes.dart';
import 'package:template/features/statics/not_found.dart';
import 'package:template/providers/auth_provider.dart';

import 'app_routes.dart';
import 'go_router_observer.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  //  final firebaseAnalyticsObserver =
  //       ref.watch(firebaseAnalyticsObserverProvider);
  ref
    ..onDispose(isAuth.dispose)
    // update the listenable, when some provider value changes
    // here, we are just interested in wheter the user's logged in
    ..listen(
      authNotifierProvider.select(
        (val) {
          debugPrint('VAL: ${val.value}');
          return val.whenData((val) => val);
        },
      ),
      (_, next) {
        isAuth.value = AsyncValue.data(next.value ?? false);
      },
    );

  final router = GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: false, // kDebugMode,
    refreshListenable: isAuth,
    initialLocation: AppRoutes.splash.path,
    errorBuilder: (context, state) => const NotFoundScreen(),
    observers: [
      // Add your navigator observers
      GoRouterObserver(),
      // firebaseAnalyticsObserver,
    ],
    redirect: (context, state) {
      if (isAuth.value.unwrapPrevious().hasError) {
        return AppRoutes.login.path;
      }

      if (isAuth.value.isLoading || !isAuth.value.hasValue) {
        return AppRoutes.splash.path;
      }

      final auth = isAuth.value.requireValue;
      final isSplash = state.uri.path == AppRoutes.splash.path;

      // Check if we are on the splash screen
      if (isSplash) {
        return auth ? AppRoutes.home.path : AppRoutes.login.path;
      }

      if (auth) {
        return auth ? AppRoutes.home.path : AppRoutes.login.path;
      }

      // No redirection needed
      return auth ? null : AppRoutes.login.path;
    },
    routes: routes,
  );

  ref.onDispose(router.dispose);

  return router;
});
