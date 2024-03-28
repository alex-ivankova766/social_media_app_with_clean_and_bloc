import 'package:logger/logger.dart';

import '../../../../shared/domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/local_feed_datasource.dart';
import '../datasources/mock_feed_datasource.dart';

Logger logger = Logger();

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this.feedDatasource, this.localFeedDatasource);
  final LocalFeedDatasource localFeedDatasource;
  final MockFeedDatasource feedDatasource;

  @override
  Future<List<Post>> getPosts() async {
    // TODO: Check internet connection. Get from database
    // if there is a active connection. Else get from local Hive.

    if ((await localFeedDatasource.getPosts()).isEmpty) {
      List<Post> posts = await feedDatasource.getPosts();
      for (final post in posts) {
        localFeedDatasource.addPost(post);
      }
      return posts;
    } else {
      logger.i('Getting the posts from Hive');
      return localFeedDatasource.getPosts();
    }
    
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    return feedDatasource.getPostsByUser(userId);
  }
  
  @override
  Future<void> createPost(Post post) {
    return localFeedDatasource.addPost(post);
  }
}
