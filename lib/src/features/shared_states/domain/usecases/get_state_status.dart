import '../../../../shared/domain/usecases/usecases.dart';
import '../../data/repositories/shared_states_repo_impl.dart';
import '../repositories/shared_states_repo.dart';

class GetStateStatus implements UseCase<StateStatus, NoParams> {
  GetStateStatus(this.stateRepository);
  final SharedStatesRepository stateRepository;

  @override
  Stream<StateStatus> call(NoParams params) {
    return stateRepository.status;
  }
}
