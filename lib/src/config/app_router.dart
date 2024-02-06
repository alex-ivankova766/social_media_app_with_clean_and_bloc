import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';

class AppRouter {
  //TODO: Add the auth bloc as an input
  AppRouter();

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'feed',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          // TODO: change to feed screen.
          return const HomeScreen();
        },
        routes: <GoRoute>[
          GoRoute(
              name: 'discover',
              path: '/discover',
              builder: (BuildContext context, GoRouterState state) {
                return Container();
              },
              routes: [
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
                return Container();
              },
              routes: [
                GoRoute(
                  name: 'signup',
                  path: 'signup',
                  builder: (BuildContext context, GoRouterState state) {
                    return Container();
                  },
                )
              ]),
        ],
      ),
    ],
    //TODO: redirect users to the login screen if they're not
    //authenticated. Else go to the feed screen
    //redirect:
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
