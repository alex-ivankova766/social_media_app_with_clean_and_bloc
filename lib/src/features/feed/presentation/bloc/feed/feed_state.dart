part of 'feed_bloc.dart';

final class FeedState extends Equatable {
  const FeedState({this.posts = const <Post>[]});
  final List<Post> posts;
  @override
  List<Object> get props => [posts];
}
