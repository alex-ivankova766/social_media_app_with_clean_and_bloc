import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class GetLoggedInUser implements UseCase<LoggedInUser, NoParams> {
  GetLoggedInUser(this.authRepository);
  final AuthRepository authRepository;

  @override
  call(NoParams params) {
    return authRepository.loggedInUser;
  }
}
