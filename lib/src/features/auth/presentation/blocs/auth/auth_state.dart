part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState._({
    this.status = AuthStatus.unknown,
    this.user = LoggedInUser.empty,
  });

  final AuthStatus status;
  final LoggedInUser user;

  const AuthState.unknown() : this._();

  const AuthState.autenticated({
    required LoggedInUser user,
  }) : this._(
          user: user,
          status: AuthStatus.authenticated,
        );

  const AuthState.unautenticated()
      : this._(
          status: AuthStatus.unauthenticated,
        );

  @override
  List<Object> get props => [
        status,
        user,
      ];
}
