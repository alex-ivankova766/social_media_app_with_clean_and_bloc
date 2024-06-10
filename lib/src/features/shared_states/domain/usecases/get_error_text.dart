import '../../../../shared/domain/usecases/usecases.dart';
import '../repositories/shared_states_repo.dart';

class GetErrorText implements UseCase<String, NoParams> {
  GetErrorText(this.statesRepository);
  final SharedStatesRepository statesRepository;

  @override
  Future<String> call(NoParams params) async {
    return statesRepository.errorText ?? '';
  }
}
