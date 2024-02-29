import 'package:equatable/equatable.dart';

import 'entities.dart';

class Post extends Equatable {
  const Post({
    required this.id,
    required this.user,
    required this.caption,
    required this.assetPath,
  });

  final String id;
  final User user;
  final String caption;
  final String assetPath;

  @override
  List<Object?> get props => [
        id,
        user,
        caption,
        assetPath,
      ];
}
