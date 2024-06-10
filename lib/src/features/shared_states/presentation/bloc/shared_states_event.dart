part of 'shared_states_bloc.dart';

abstract class SharedStatesEvent extends Equatable {
  const SharedStatesEvent();

  @override
  List<Object> get props => [];
}

class StateGetStatus extends SharedStatesEvent {
  const StateGetStatus(this.status);
  final StateStatus status;
  @override
  List<Object> get props => [status];
}

class GoToInitialStatusEvent extends SharedStatesEvent {}
