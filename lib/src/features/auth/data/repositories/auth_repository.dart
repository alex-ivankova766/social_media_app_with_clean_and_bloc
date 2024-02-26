import '../../../../shared/domain/entities/entities.dart';
import '../../domain/entities/logged_in_user.dart';
import '../datasources/mock_auth_datasource.dart';

abstract class AuthRepository {
  Stream<AuthStatus> get status;
  Future<LoggedInUser> get loggedInUser;
  Future<void> signup({required LoggedInUser loggedInUser});
  Future<void> login({
    required Username username,
    required Password password,
  });
  Future<void> logout();
}
