import 'package:hive/hive.dart';

import '../../domain/entities/entities.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  const UserModel(
      {required this.id,
      required this.username,
      this.followers = 0,
      this.following = 0,
      this.imagePath});

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final int followers;
  @HiveField(3)
  final int following;
  @HiveField(4)
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
