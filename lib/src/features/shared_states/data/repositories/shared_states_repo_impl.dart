import 'dart:async';

import '../../domain/repositories/shared_states_repo.dart';

enum StateStatus { initial, loading, loaded, failure }

class SharedStatesRepositoryImpl implements SharedStatesRepository {
  SharedStatesRepositoryImpl();

  final _stateStreamController = StreamController<StateStatus>();
  String? _errorText;
  StateStatus _currentState = StateStatus.initial;

  @override
  Stream<StateStatus> get status async* {
    yield StateStatus.initial;
    yield* _stateStreamController.stream;
  }

  @override
  Future<void> setLoading() async {
    _currentState = StateStatus.loading;
    _stateStreamController.add(StateStatus.loading);
  }

  @override
  Future<void> setFailure(String errorText) async {
    _errorText = errorText;
    _currentState = StateStatus.failure;
    _stateStreamController.add(StateStatus.failure);
  }

  @override
  Future<void> setLoaded() async {
    _currentState = StateStatus.loaded;
    _stateStreamController.add(StateStatus.loaded);
  }

  @override
  String? get errorText => _errorText;

  @override
  Future<void> setInitial() async {
    _currentState = StateStatus.initial;
    _stateStreamController.add(StateStatus.initial);
  }

  @override
  StateStatus get currentStateStatus => _currentState;
}
