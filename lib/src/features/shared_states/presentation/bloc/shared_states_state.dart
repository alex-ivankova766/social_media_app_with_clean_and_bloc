part of 'shared_states_bloc.dart';

sealed class SharedState extends Equatable {
  const SharedState();

  @override
  List<Object> get props => [];
}

class SharedStatesInitial extends SharedState {}

class SharedStatesLoading extends SharedState {}

class SharedStatesLoaded extends SharedState {}

class SharedStatesFailure extends SharedState {
  final String errorText;
  const SharedStatesFailure(this.errorText);
}
