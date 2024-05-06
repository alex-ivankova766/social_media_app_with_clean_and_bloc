import '../../../../shared/data/datasources/post_data.dart';
import '../../../../shared/data/datasources/user_data.dart';
import '../../../../shared/data/models/post_model.dart';
import '../../../../shared/data/models/user_model.dart';
import '../../../../shared/domain/entities/entities.dart';

abstract class MockFeedDatasource {
  Future<List<Post>> getPosts();
  Future<List<Post>> getPostsByUser(String userId);
  Future<List<User>> getUsers();
  Future<User> getUser(String userId);
}

class MockFeedDatasourceImpl implements MockFeedDatasource {
  @override
  Future<List<Post>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 300), () {});

    return posts.map((post) {
      Map<String, dynamic> user = users.where((user) {
        return user['id'] == post['userId'];
      }).first;
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300), () {});

    return posts.where((post) => post['userId'] == userId).map((post) {
      Map<String, dynamic> user = users.where((user) {
        return user['id'] == userId;
      }).first;
      return PostModel.fromJson(post, user).toEntity();
    }).toList();
  }

  @override
  Future<User> getUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return UserModel.fromJson(users.firstWhere((user) => user['id'] == userId))
        .toEntity();
  }

  @override
  Future<List<User>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return users.map((user) => UserModel.fromJson(user).toEntity()).toList();
  }
}
