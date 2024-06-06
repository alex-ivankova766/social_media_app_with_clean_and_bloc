// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $otherShell,
    ];

RouteBase get $otherShell => ShellRouteData.$route(
      factory: $OtherShellExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/error/:errorText',
          name: 'error',
          factory: $ErrorDialogRouteExtension._fromState,
        ),
        ShellRouteData.$route(
          factory: $AuthShellExtension._fromState,
          routes: [
            GoRouteData.$route(
              path: '/login',
              name: 'login',
              factory: $LoginRouteExtension._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'signup',
                  name: 'signup',
                  factory: $SignupRouteExtension._fromState,
                ),
              ],
            ),
          ],
        ),
      ],
    );

extension $OtherShellExtension on OtherShell {
  static OtherShell _fromState(GoRouterState state) => OtherShell();
}

extension $ErrorDialogRouteExtension on ErrorDialogRoute {
  static ErrorDialogRoute _fromState(GoRouterState state) => ErrorDialogRoute(
        state.pathParameters['errorText']!,
      );

  String get location => GoRouteData.$location(
        '/error/${Uri.encodeComponent(errorText)}',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $AuthShellExtension on AuthShell {
  static AuthShell _fromState(GoRouterState state) => AuthShell();
}

extension $LoginRouteExtension on LoginRoute {
  static LoginRoute _fromState(GoRouterState state) => LoginRoute();

  String get location => GoRouteData.$location(
        '/login',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SignupRouteExtension on SignupRoute {
  static SignupRoute _fromState(GoRouterState state) => SignupRoute();

  String get location => GoRouteData.$location(
        '/login/signup',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
