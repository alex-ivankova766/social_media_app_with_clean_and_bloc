import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../index.dart';

part 'index.g.dart';

@TypedShellRoute<OtherShell>(
  routes: [
    TypedGoRoute<ErrorDialogRoute>(
      path: '/error/:errorText',
      name: 'error',
    ),
    TypedShellRoute<AuthShell>(
      routes: [
        TypedGoRoute<LoginRoute>(
          name: 'login',
          path: '/login',
          routes: [
            TypedGoRoute<SignupRoute>(
              name: 'signup',
              path: 'signup',
            ),
          ],
        ),
      ],
    ),
  ],
)
@immutable
class OtherShell extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return navigator;
  }
}
