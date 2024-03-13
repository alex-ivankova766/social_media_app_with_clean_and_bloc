import '../../../../shared/domain/entities/entities.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<User> getUser(String userId);
}
