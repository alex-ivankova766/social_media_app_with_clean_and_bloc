import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/data/repositories/shared_states_repo_impl.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/domain/usecases/go_to_initial_shared_state.dart';

import '../../../../features/feed/data/repositories/repositories.dart';
import '../../../../features/feed/domain/usecases/usecases.dart';
import '../../../../features/feed/presentation/bloc/feed/feed_bloc.dart';
import '../../../../features/feed/presentation/view/screens.dart';

@immutable
class FeedRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
        create: (context) => FeedBloc(
              getPosts: GetPosts(
                context.read<PostRepositoryImpl>(),
                context.read<SharedStatesRepositoryImpl>(),
              ),
            )..add(FeedGetPosts()),
        child: const FeedScreen());
  }
}
