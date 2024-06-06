import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/handlers/handlers.dart';

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => const LoadingDialog(),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: LoadingIndicator(),
    );
  }
}

@immutable
class ErrorDialogRoute extends GoRouteData {
  final String errorText;
  const ErrorDialogRoute(this.errorText);
  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    return ErrorDialogPage(errorText);
  }
}

class ErrorDialogPage<T> extends Page<T> {
  final String errorText;
  const ErrorDialogPage(this.errorText);
  @override
  Route<T> createRoute(BuildContext context) {
    return DialogRoute<T>(
      context: context,
      settings: this,
      builder: (context) => ErrorIndicator(
        errorText: errorText,
      ),
    );
  }
}
