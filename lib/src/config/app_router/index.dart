import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/data/datasources/mock_auth_datasource.dart';
import '../../features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'routes/index.dart';
import 'routes/with_nav_bar/index.dart' as with_nav_bar;
import 'routes/without_nav_bar/index.dart' as without_nav_bar;

class AppRouter {
  final AuthBloc authBloc;

  AppRouter({
    required this.authBloc,
  });

  late final GoRouter router = GoRouter(
    initialLocation: FeedRoute().location,
    routes: [
      GoRoute(
        path: '/error:errorText',
        pageBuilder: (context, state) {
          final errorText = state.pathParameters['errorText']!;
          return ErrorDialogPage(
            errorText,
          );
        },
      ),
      ...with_nav_bar.$appRoutes,
      ...without_nav_bar.$appRoutes,
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final loginLocation = state.namedLocation('login');
      final signupLocation = state.namedLocation('signup');

      final bool isLoggedIn = authBloc.state.status == AuthStatus.authenticated;
      final isLoggingIn = state.matchedLocation == loginLocation;
      final isSigninUp = state.matchedLocation == signupLocation;
      if (!isLoggedIn && !isLoggingIn && !isSigninUp) {
        return '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return '/';
      }
      if (isLoggedIn && isSigninUp) {
        return '/';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
