import '../../domain/entities/entities.dart';
import 'user_model.dart';

class PostModel {
  const PostModel({
    required this.id,
    required this.user,
    required this.caption,
    required this.assetPath,
  });
  final String id;
  final UserModel user;
  final String caption;
  final String assetPath;

  factory PostModel.fromJson(
    Map<String, dynamic> post,
    Map<String, dynamic> user,
  ) {
    return PostModel(
      id: post['id'],
      user: UserModel.fromJson(user),
      caption: post['caption'],
      assetPath: post['assetPath'],
    );
  }

  factory PostModel.fromEntity(Post post) {
    return PostModel(
      id: post.id,
      user: UserModel.fromEntity(post.user),
      caption: post.caption,
      assetPath: post.assetPath,
    );
  }

  Post toEntity() {
    return Post(
      id: id,
      user: user.toEntity(),
      caption: caption,
      assetPath: assetPath,
    );
  }
}
