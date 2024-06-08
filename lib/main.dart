import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/data/repositories/shared_states_repo_impl.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/domain/usecases/get_error_text.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/domain/usecases/get_state_status.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/domain/usecases/go_to_initial_shared_state.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/presentation/bloc/shared_states_bloc.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/shared/presentation/handlers/handlers.dart';

import 'src/config/config.dart';
import 'src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/usecases/get_auth_status.dart';
import 'src/features/auth/domain/usecases/get_logged_in_user.dart';
import 'src/features/auth/domain/usecases/login_user.dart';
import 'src/features/auth/domain/usecases/logout_user.dart';
import 'src/features/auth/domain/usecases/signup_user.dart';
import 'src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'src/features/auth/presentation/cubits/login/login_cubit.dart';
import 'src/features/auth/presentation/cubits/signup/signup_cubit.dart';
import 'src/features/feed/data/datasources/local_feed_datasource.dart';
import 'src/features/feed/data/datasources/mock_feed_datasource.dart';
import 'src/features/feed/data/repositories/post_repository_impl.dart';
import 'src/features/feed/data/repositories/user_repository_impl.dart';
import 'src/features/feed/domain/usecases/get_posts.dart';
import 'src/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'src/shared/data/models/post_model.dart';
import 'src/shared/data/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(PostModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (ctx) => AuthRepositoryImpl(
            MockAuthDatasourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (ctx) => UserRepositoryImpl(
            MockFeedDatasourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (ctx) => PostRepositoryImpl(
            MockFeedDatasourceImpl(),
            LocalFeedDatasourceImpl(),
          ),
        ),
        RepositoryProvider(
          create: (ctx) => SharedStatesRepositoryImpl(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (ctx) => AuthBloc(
              getAuthStatus: GetAuthStatus(ctx.read<AuthRepositoryImpl>()),
              getLoggedInUser: GetLoggedInUser(ctx.read<AuthRepositoryImpl>()),
              logoutUser: LogoutUser(ctx.read<AuthRepositoryImpl>()),
            ),
          ),
          BlocProvider(
            create: (ctx) => SharedStatesBloc(
                getStateStatus:
                    GetStateStatus(ctx.read<SharedStatesRepositoryImpl>()),
                getErrorText:
                    GetErrorText(ctx.read<SharedStatesRepositoryImpl>()),
                goToInitialStatus: GoToInitialSharedStatus(
                    ctx.read<SharedStatesRepositoryImpl>())),
          ),
          BlocProvider(
            create: (ctx) => LoginCubit(
                loginUser: LoginUser(ctx.read<AuthRepositoryImpl>())),
          ),
          BlocProvider(
            create: (ctx) => SignupCubit(
                signupUser: SignupUser(ctx.read<AuthRepositoryImpl>())),
          ),
          BlocProvider(
            create: (context) => FeedBloc(
              getPosts: GetPosts(
                context.read<PostRepositoryImpl>(),
                context.read<SharedStatesRepositoryImpl>(),
              ),
            ),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'Social media application',
            theme: CustomTheme().theme(),
            routerConfig: AppRouter(authBloc: context.read<AuthBloc>()).router,
            builder: (context, child) {
              return Stack(
                children: [
                  child!,
                  BlocBuilder<SharedStatesBloc, SharedState>(
                    builder: (context, state) {
                      if (state is SharedStatesLoading) {
                        return const LoadingIndicator();
                      } else if (state is SharedStatesFailure) {
                        return ErrorIndicator(
                          errorText: state.errorText,
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              );
            },
          );
        }),
      ),
    );
  }
}
