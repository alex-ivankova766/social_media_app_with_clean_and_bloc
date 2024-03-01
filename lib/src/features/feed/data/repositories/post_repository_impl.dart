import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/feed/data/datasources/mock_feed_datasource.dart';

import '../../../../shared/domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this.feedDatasource);
  // TODO: Add a local datasource using Hive
  final MockFeedDatasource feedDatasource;

  @override
  Future<List<Post>> getPosts() async {
    return feedDatasource.getPosts();
  }

  @override
  Future<List<Post>> getPostsByUser(String userId) async {
    return feedDatasource.getPostsByUser(userId);
  }
}
