import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/shared_states_repo.dart';

class GoToInitialSharedStatus implements UseCase<void, NoParams> {
  GoToInitialSharedStatus(this.statesRepository);
  final SharedStatesRepository statesRepository;

  @override
  Future<void> call(NoParams params) async {
    return statesRepository.setInitial();
  }
}
