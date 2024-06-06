import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/feed/data/repositories/repositories.dart';
import '../../../../features/feed/domain/usecases/usecases.dart';
import '../../../../features/feed/presentation/bloc/discover/discover_bloc.dart';
import '../../../../features/feed/presentation/view/discover_screen.dart';

@immutable
class DiscoverRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
        create: (context) => DiscoverBloc(
              getUsers: GetUsers(
                context.read<UserRepositoryImpl>(),
              ),
            )..add(DiscoverGetUsers()),
        child: const DiscoverScreen());
  }
}

@immutable
class DiscoverUserRoute extends GoRouteData {
  final String userId;
  const DiscoverUserRoute(this.userId);
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Container();
  }
}
