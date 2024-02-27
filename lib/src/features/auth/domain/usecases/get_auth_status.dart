import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class GetAuthStatus implements UseCase<LoggedInUser, NoParams> {
  GetAuthStatus(this.authRepository);
  final AuthRepository authRepository;

  @override
  call(NoParams params) {
    return authRepository.status;
  }
}
