part of 'discover_bloc.dart';

abstract class DiscoverState extends Equatable {
  const DiscoverState();

  @override
  List<Object> get props => [];
}

class DiscoverLoading extends DiscoverState {}

class DiscoverLoaded extends DiscoverState {
  const DiscoverLoaded({this.users = const <User>[]});
  final List<User> users;
  @override
  List<Object> get props => [users];
}
