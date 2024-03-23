import '../../../../shared/domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/mock_feed_datasource.dart';

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
