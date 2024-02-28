import '../../../../shared/domain/usecases/usecases.dart';
import '../../data/datasources/mock_auth_datasource.dart';
import '../repositories/auth_repository.dart';

class GetAuthStatus implements UseCase<AuthStatus, NoParams> {
  GetAuthStatus(this.authRepository);
  final AuthRepository authRepository;

  @override
  Stream<AuthStatus> call(NoParams params) {
    return authRepository.status;
  }
}
