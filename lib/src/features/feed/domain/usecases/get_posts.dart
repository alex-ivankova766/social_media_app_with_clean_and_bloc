import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../../domain/repositories/post_repository.dart';

class GetPosts implements UseCase<List<Post>, NoParams> {
  GetPosts(this.postRepository);
  final PostRepository postRepository;

  @override
  Future<List<Post>> call(NoParams params) async {
    return postRepository.getPosts();
  }
}
