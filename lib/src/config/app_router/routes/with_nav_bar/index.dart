import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/presentation/widgets/custom_nav_bar.dart';
import '../index.dart';

part 'index.g.dart';

@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch<FeedBranch>(
      routes: [
        TypedGoRoute<FeedRoute>(
          name: 'feed',
          path: '/',
        ),
      ],
    ),
    TypedStatefulShellBranch<ManageContentBranch>(
      routes: [
        TypedGoRoute<ManageContentRoute>(
          name: 'manage_content',
          path: '/manage-content',
        ),
      ],
    ),
    TypedStatefulShellBranch<AddContentBranch>(
      routes: [
        TypedGoRoute<AddContentRoute>(
          name: 'add_content',
          path: '/add-content',
        ),
      ],
    ),
    TypedStatefulShellBranch<DiscoverBranch>(
      routes: [
        TypedGoRoute<DiscoverRoute>(
          name: 'discover',
          path: '/discover',
          routes: [
            TypedGoRoute<DiscoverUserRoute>(
              name: 'user',
              path: ':userId',
            ),
          ],
        ),
      ],
    ),
  ],
)
@immutable
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();

  Page getPage({
    required Widget child,
    required GoRouterState state,
  }) {
    return MaterialPage(
      key: state.pageKey,
      child: child,
    );
  }

  @override
  pageBuilder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return getPage(
      child: BottomNavigationWrapper(
        child: navigationShell,
      ),
      state: state,
    );
  }
}

/// Главная
@immutable
class FeedBranch extends StatefulShellBranchData {}

/// Записи
@immutable
class ManageContentBranch extends StatefulShellBranchData {}

/// Чаты
@immutable
class AddContentBranch extends StatefulShellBranchData {}

/// Профиль
@immutable
class DiscoverBranch extends StatefulShellBranchData {}
