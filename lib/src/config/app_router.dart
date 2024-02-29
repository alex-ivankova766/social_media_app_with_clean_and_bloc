import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/auth/data/datasources/mock_auth_datasource.dart';

import '../features/auth/presentation/blocs/auth/auth_bloc.dart';
import '../features/auth/presentation/views/screens.dart';
import '../features/feed/presentation/view/screens.dart';

class AppRouter {
  AppRouter(this.authBloc);

  final AuthBloc authBloc;

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'feed',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          // TODO: change to feed screen.
          return const FeedScreen();
        },
      ),
      GoRoute(
          name: 'discover',
          path: '/discover',
          builder: (BuildContext context, GoRouterState state) {
            return const DiscoverScreen();
          },
          routes: <GoRoute>[
            GoRoute(
              name: 'user',
              path: ':userId',
              builder: (BuildContext context, GoRouterState state) {
                return Container();
              },
            )
          ]),
      GoRoute(
          name: 'login',
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
          routes: [
            GoRoute(
              name: 'signup',
              path: 'signup',
              builder: (BuildContext context, GoRouterState state) {
                return const SignUpScreen();
              },
            )
          ]),
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
