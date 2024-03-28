import 'dart:io';

import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/feed/domain/repositories/post_repository.dart';

import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/domain/usecases/usecases.dart';

class CreatePost implements UseCase<void, CreatePostParams> {
  CreatePost(this.postRepository);
  final PostRepository postRepository;

  @override
  Future<void> call(params) {
    return postRepository.createPost(params.post);
  }

}

class CreatePostParams extends Params {
  CreatePostParams({
    required this.post,

  });
  final Post post;

  @override
  List<Object?> get props => [
        post
      ];
}