import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.username,
      this.followers = 0,
      this.following = 0,
      this.imagePath});
  final String id;
  final Username username;
  final int followers;
  final int following;
  final String? imagePath;

  static const empty = User(id: 'user_0', username: Username.pure());

  @override
  List<Object?> get props => [id, username, followers, following, imagePath];
}

enum UsernameValidationError { invalid }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  static final RegExp _usernameRegExp =
      RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+$');

  @override
  UsernameValidationError? validator(String? value) {
    return _usernameRegExp.hasMatch(value ?? '')
        ? null
        : UsernameValidationError.invalid;
  }
}
