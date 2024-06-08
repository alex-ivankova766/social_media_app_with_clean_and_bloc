import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../shared/domain/usecases/usecases.dart';
import '../../data/repositories/shared_states_repo_impl.dart';
import '../../domain/usecases/get_error_text.dart';
import '../../domain/usecases/get_state_status.dart';
import '../../domain/usecases/go_to_initial_shared_state.dart';

part 'shared_states_event.dart';
part 'shared_states_state.dart';

class SharedStatesBloc extends Bloc<SharedStatesEvent, SharedState> {
  final GetStateStatus _getStateStatus;
  final GetErrorText _getErrorText;
  final GoToInitialSharedStatus _goToInitialStatus;
  late StreamSubscription<StateStatus> _stateStatusSubscription;
  SharedStatesBloc({
    required GetStateStatus getStateStatus,
    required GetErrorText getErrorText,
    required GoToInitialSharedStatus goToInitialStatus,
  })  : _getStateStatus = getStateStatus,
        _getErrorText = getErrorText,
        _goToInitialStatus = goToInitialStatus,
        super(SharedStatesInitial()) {
    on<StateGetStatus>(_onStateGetStatus);
    on<GoToInitialStatusEvent>(_onGoToInitialStatus);

    _stateStatusSubscription = _getStateStatus(NoParams()).listen((status) {
      add(StateGetStatus(status));
    });
  }
  void _onGoToInitialStatus(
    GoToInitialStatusEvent event,
    Emitter<SharedState> emit,
  ) {
    _goToInitialStatus(NoParams());
  }

  Future<void> _onStateGetStatus(
    StateGetStatus event,
    Emitter<SharedState> emit,
  ) async {
    switch (event.status) {
      case StateStatus.initial:
        return emit(SharedStatesInitial());
      case StateStatus.loading:
        return emit(SharedStatesLoading());
      case StateStatus.loaded:
        return emit(SharedStatesLoaded());
      case StateStatus.failure:
        String errorText = await _getErrorText(NoParams());
        return emit(SharedStatesFailure(errorText));
    }
  }

  @override
  Future<void> close() {
    _stateStatusSubscription.cancel();
    return super.close();
  }
}
