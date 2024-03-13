import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/shared/domain/entities/user.dart';

import '../../domain/repositories/user_repository.dart';
import '../datasources/mock_feed_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.userDatasource);
  // TODO: Add a local datasource using Hive
  final MockFeedDatasource userDatasource;

  @override
  Future<User> getUser(String userId) {
    return userDatasource.getUser(userId);
  }

  @override
  Future<List<User>> getUsers() {
    return userDatasource.getUsers();
  }
}
