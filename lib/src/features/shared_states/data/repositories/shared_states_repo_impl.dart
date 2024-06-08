import 'dart:async';

import '../../domain/repositories/shared_states_repo.dart';

enum StateStatus { initial, loading, loaded, failure }

class SharedStatesRepositoryImpl implements SharedStatesRepository {
  SharedStatesRepositoryImpl();

  final _stateStreamController = StreamController<StateStatus>();
  String? _errorText;

  @override
  Stream<StateStatus> get status async* {
    yield StateStatus.initial;
    yield* _stateStreamController.stream;
  }

  @override
  Future<void> setLoading() async {
    _stateStreamController.add(StateStatus.loading);
  }

  @override
  Future<void> setFailure(String errorText) async {
    _errorText = errorText;
    _stateStreamController.add(StateStatus.failure);
  }

  @override
  Future<void> setLoaded() async {
    _stateStreamController.add(StateStatus.loaded);
  }

  @override
  String? get errorText => _errorText;

  @override
  Future<void> setInitial() async {
    _stateStreamController.add(StateStatus.initial);
  }
}
