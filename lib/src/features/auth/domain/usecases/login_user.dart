import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/domain/usecases/usecases.dart';
import '../entities/logged_in_user.dart';
import '../repositories/auth_repository.dart';

class LoginUser implements UseCase<void, LoginUserParams> {
  LoginUser(this.authRepository);
  final AuthRepository authRepository;

  @override
  Future<void> call(LoginUserParams params) {
    return authRepository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginUserParams extends Params {
  LoginUserParams({
    required this.username,
    required this.password,
  });
  final Username username;
  final Password password;

  @override
  List<Object?> get props => [
        username,
        password,
      ];
}
