import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/content/presentation/view/screens.dart';

@immutable
class ManageContentRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ManageContentScreen();
  }
}
