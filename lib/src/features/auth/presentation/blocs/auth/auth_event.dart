part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthGetStatus extends AuthEvent {
  const AuthGetStatus(this.status);
  final AuthStatus status;
  @override
  List<Object> get props => [status];
}

class AuthLogoutUser extends AuthEvent {}
