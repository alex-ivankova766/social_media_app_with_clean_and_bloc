import '../../../../shared/domain/entities/entities.dart';

abstract class PostRepository {
  Future<List<Post>> getPosts();
  Future<List<Post>> getPostsByUser(String userId);
  Future<void> createPost(Post post);
}
