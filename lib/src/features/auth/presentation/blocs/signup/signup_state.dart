part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.errorText,
  });
  final Username username;
  final Email email;
  final Password password;
  final FormzStatus status;
  final String? errorText;

  factory SignupState.initial() {
    return const SignupState(
      username: Username.pure(),
      email: Email.pure(),
      password: Password.pure(),
      status: FormzStatus.pure,
      errorText: null,
    );
  }

  SignupState copyWith({
    Username? username,
    Email? email,
    Password? password,
    FormzStatus? status,
    String? errorText,
  }) {
    return SignupState(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }

  @override
  List<Object?> get props => [
        username,
        email,
        password,
        status,
        errorText,
      ];
}
