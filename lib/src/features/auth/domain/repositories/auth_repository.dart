import '../../../../shared/domain/entities/entities.dart';
import '../../data/datasources/mock_auth_datasource.dart';
import '../entities/logged_in_user.dart';

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
