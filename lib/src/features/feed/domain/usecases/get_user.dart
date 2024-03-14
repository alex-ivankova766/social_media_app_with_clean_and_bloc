import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/user_repository.dart';

class GetUser implements UseCase<User, GetUserParams> {
  GetUser(this.userRepository);
  final UserRepository userRepository;

  @override
  Future<User> call(GetUserParams params) async {
    return userRepository.getUser(params.userId);
  }
}

class GetUserParams extends Params {
  GetUserParams({required this.userId});
  final String userId;

  @override
  List<Object?> get props => [userId];
}
