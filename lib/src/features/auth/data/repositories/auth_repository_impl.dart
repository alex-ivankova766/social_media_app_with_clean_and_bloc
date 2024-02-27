import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/auth/data/datasources/mock_auth_datasource.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/auth/domain/entities/logged_in_user.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/shared/domain/entities/user.dart';

import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl(this.authDatasource);
  final MockAuthDatasource authDatasource;

  @override
  Stream<AuthStatus> get status => authDatasource.status;

  @override
  Future<LoggedInUser> get loggedInUser => authDatasource.loggedInUser;

  @override
  Future<void> login({
    required Username username,
    required Password password,
  }) {
    return authDatasource.login(
      username: username,
      password: password,
    );
  }

  @override
  Future<void> logout() {
    return authDatasource.logout();
  }

  @override
  Future<void> signup({
    required LoggedInUser loggedInUser,
  }) {
    return authDatasource.signup(
      loggedInUser: loggedInUser,
    );
  }
}
