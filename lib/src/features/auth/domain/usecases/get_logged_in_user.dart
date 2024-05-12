import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/entities.dart';
import '../repositories/auth_repository.dart';

class GetLoggedInUser implements UseCase<LoggedInUser, NoParams> {
  GetLoggedInUser(this.authRepository);
  final AuthRepository authRepository;

  @override
  Future<LoggedInUser> call(NoParams params) {
    return authRepository.loggedInUser;
  }
}
