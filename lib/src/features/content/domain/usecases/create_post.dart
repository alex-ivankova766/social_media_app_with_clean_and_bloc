import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../../../feed/domain/repositories/repositories.dart';

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
