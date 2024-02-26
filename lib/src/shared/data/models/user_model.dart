// class UserModel extends User {}

import '../../domain/entities/entities.dart';

class UserModel {
  const UserModel(
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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      followers: json['followers'],
      following: json['following'],
      imagePath: json['imagePath'],
    );
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username.value,
      followers: user.followers,
      following: user.following,
      imagePath: user.imagePath,
    );
  }

  User toEntity() {
    return User(
      id: id,
      username: Username.dirty(username),
      imagePath: imagePath,
      followers: followers,
      following: following,
    );
  }
}
