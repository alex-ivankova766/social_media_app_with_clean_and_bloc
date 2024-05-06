import '../../../../shared/domain/entities/user.dart';
import '../../domain/entities/logged_in_user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/mock_auth_datasource.dart';

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
