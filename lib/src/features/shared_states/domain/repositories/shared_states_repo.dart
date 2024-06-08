import '../../data/repositories/shared_states_repo_impl.dart';

abstract interface class SharedStatesRepository {
  Future<void> setInitial();
  Future<void> setLoading();
  Future<void> setLoaded();
  Future<void> setFailure(String errorText);
  Stream<StateStatus> get status;
  String? get errorText;
}
