import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/auth/presentation/views/screens.dart';

// Роуты экранов авторизации
@immutable
class AuthShell extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return navigator;
  }
}

@immutable
class LoginRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LoginScreen();
  }
}

@immutable
class SignupRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SignUpScreen();
  }
}
