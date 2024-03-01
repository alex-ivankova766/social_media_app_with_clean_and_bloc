import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../../data/repositories/post_repository_impl.dart';

class GetPostsByUser implements UseCase<List<Post>, GetPostByUserParams> {
  GetPostsByUser(this.postRepository);
  final PostRepositoryImpl postRepository;

  @override
  Future<List<Post>> call(GetPostByUserParams params) async {
    return postRepository.getPostsByUser(params.userId);
  }
}

class GetPostByUserParams extends Params {
  GetPostByUserParams({required this.userId});
  final String userId;

  @override
  List<Object?> get props => [userId];
}
