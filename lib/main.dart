import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/config/config.dart';
import 'src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'src/features/auth/data/repositories/auth_repository_impl.dart';
import 'src/features/auth/domain/usecases/get_auth_status.dart';
import 'src/features/auth/domain/usecases/get_logged_in_user.dart';
import 'src/features/auth/domain/usecases/login_user.dart';
import 'src/features/auth/domain/usecases/logout_user.dart';
import 'src/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'src/features/auth/presentation/blocs/login/login_cubit.dart';

void main() {
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
        )
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
        ],
        child: MaterialApp.router(
          title: 'Social media application',
          theme: CustomTheme().theme(),
          routerConfig: AppRouter().router,
        ),
      ),
    );
  }
}
