import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/content/domain/usecases/create_post.dart';

import '../features/auth/data/datasources/mock_auth_datasource.dart';
import '../features/auth/presentation/blocs/auth/auth_bloc.dart';
import '../features/auth/presentation/views/screens.dart';
import '../features/content/presentation/cubit/add_content_cubit.dart';
import '../features/content/presentation/view/add_content_screen.dart';
import '../features/feed/data/repositories/post_repository_impl.dart';
import '../features/feed/data/repositories/user_repository_impl.dart';
import '../features/feed/domain/usecases/get_posts.dart';
import '../features/feed/domain/usecases/get_users.dart';
import '../features/feed/presentation/bloc/discover/discover_bloc.dart';
import '../features/feed/presentation/bloc/feed/feed_bloc.dart';
import '../features/feed/presentation/view/screens.dart';

class AppRouter {
  AppRouter(this.authBloc);

  final AuthBloc authBloc;

  late final GoRouter router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        name: 'feed',
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
              create: (context) => FeedBloc(
                    getPosts: GetPosts(
                      context.read<PostRepositoryImpl>(),
                    ),
                  )..add(FeedGetPosts()),
              child: const FeedScreen());
        },
      ),
      GoRoute(
          name: 'discover',
          path: '/discover',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
                create: (context) => DiscoverBloc(
                      getUsers: GetUsers(
                        context.read<UserRepositoryImpl>(),
                      ),
                    )..add(DiscoverGetUsers()),
                child: const DiscoverScreen());
          },
          routes: <GoRoute>[
            GoRoute(
              name: 'user',
              path: ':userId',
              builder: (BuildContext context, GoRouterState state) {
                return Container();
              },
            )
          ]),
      GoRoute(
        name: 'add_content',
        path: '/add-content',
        builder: (BuildContext context, GoRouterState state) {
          return BlocProvider(
            create: (context) => AddContentCubit(
                createPost: CreatePost(context.read<PostRepositoryImpl>())),
            child: const AddContentScreen(),
          );
        },
      ),
      GoRoute(
          name: 'login',
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return const LoginScreen();
          },
          routes: [
            GoRoute(
              name: 'signup',
              path: 'signup',
              builder: (BuildContext context, GoRouterState state) {
                return const SignUpScreen();
              },
            )
          ]),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final loginLocation = state.namedLocation('login');
      final signupLocation = state.namedLocation('signup');

      final bool isLoggedIn = authBloc.state.status == AuthStatus.authenticated;
      final isLoggingIn = state.matchedLocation == loginLocation;
      final isSigninUp = state.matchedLocation == signupLocation;
      if (!isLoggedIn && !isLoggingIn && !isSigninUp) {
        return '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return '/';
      }
      if (isLoggedIn && isSigninUp) {
        return '/';
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
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
