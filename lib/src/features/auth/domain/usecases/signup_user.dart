import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class SignupUser implements UseCase<void, SignupUserParams> {
  SignupUser(this.authRepository);
  final AuthRepository authRepository;

  @override
  Future<void> call(SignupUserParams params) {
    // TODO: Add another repository to save the user into a database when she/he register.
    return authRepository.signup(
      loggedInUser: params.user,
    );
  }
}

class SignupUserParams extends Params {
  SignupUserParams({
    required this.user,
  });
  final LoggedInUser user;

  @override
  List<Object?> get props => [
        user,
      ];
}
