import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/data/repositories/shared_states_repo_impl.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/shared_states/domain/repositories/shared_states_repo.dart';

import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../../domain/repositories/post_repository.dart';

class GetPosts implements UseCase<List<Post>, NoParams> {
  GetPosts(this.postRepository, this.statesRepository);
  final PostRepository postRepository;
  final SharedStatesRepository statesRepository;

  @override
  Future<List<Post>> call(NoParams params) async {
    statesRepository.setLoading();
    try {
      List<Post> posts = await postRepository.getPosts();
      statesRepository.setLoaded();
      return posts;
    } catch (e) {
      if (await statesRepository.status.last != StateStatus.initial) {
        statesRepository.setFailure(e.toString());
        rethrow;
      } else {
        return [];
      }
    }
  }
}
