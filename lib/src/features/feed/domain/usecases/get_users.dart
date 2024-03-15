import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/user_repository.dart';

class GetUsers implements UseCase<List<User>, NoParams> {
  GetUsers(this.userRepository);
  final UserRepository userRepository;

  @override
  Future<List<User>> call(NoParams params) async {
    return userRepository.getUsers();
  }
}
