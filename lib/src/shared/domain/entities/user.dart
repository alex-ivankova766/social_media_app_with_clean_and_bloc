import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(
      {required this.id,
      required this.username,
      this.followers = 0,
      this.following = 0,
      this.imagePath});
  final String id;
  final String username;
  final int followers;
  final int following;
  final String? imagePath;

  static const empty = User(id: 'user_0', username: '-');

  @override
  List<Object?> get props => [id, username, followers, following, imagePath];
}
