import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/feed/presentation/view/screens.dart';

@immutable
class FeedRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FeedScreen();
  }
}
