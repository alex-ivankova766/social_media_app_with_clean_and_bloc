import 'package:hive_flutter/hive_flutter.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/shared/data/models/post_model.dart';

import '../../../../shared/domain/entities/entities.dart';

abstract class LocalFeedDatasource {
  Future<List<Post>> getPosts();
  Future<void> addPost(Post post);
  Future<void> deleteAllPost();
}

class LocalFeedDatasourceImpl extends LocalFeedDatasource {
  String boxName = 'posts';
  Type boxType = PostModel;

  @override
  Future<void> addPost(Post post) async {
    Box box = await _openBox();
    await box.put(post.id, PostModel.fromEntity(post));
  }

  @override
  Future<void> deleteAllPost() async {
    Box box = await _openBox();
    await box.clear();
  }

  @override
  Future<List<Post>> getPosts() {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  Future<Box> _openBox() {
    return Hive.openBox<PostModel>(boxName);
  }
}
