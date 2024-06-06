import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
            create: (ctx) => LoginCubit(
                loginUser: LoginUser(ctx.read<AuthRepositoryImpl>())),
          ),
          BlocProvider(
            create: (ctx) => SignupCubit(
                signupUser: SignupUser(ctx.read<AuthRepositoryImpl>())),
          ),
        ],
        child: Builder(
          builder: (context) {
            return MaterialApp.router(
              title: 'Social media application',
              theme: CustomTheme().theme(),
              routerConfig:
                  AppRouter(authBloc: context.read<AuthBloc>()).router,
            );
          },
        ),
      ),
    );
  }
}
