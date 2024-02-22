import '../../../../shared/domain/entities/entities.dart';

class LoggedInUser extends User {
  final String? email;

  const LoggedInUser(
      {required super.id,
      required super.username,
      this.email,
      super.imagePath,
      super.followers,
      super.following});

  static const empty = LoggedInUser(id: '-', username: '-', email: '-');

  @override
  List<Object?> get props =>
      [id, username, followers, following, imagePath, email];

  LoggedInUser copyWith({
    String? id,
    String? username,
    String? email,
    int? followers,
    int? following,
    String? imagePath,
  }) =>
      LoggedInUser(
          id: id ?? this.id,
          username: username ?? this.username,
          email: email ?? this.email,
          followers: followers ?? this.followers,
          following: following ?? this.following,
          imagePath: imagePath ?? this.imagePath);
}
