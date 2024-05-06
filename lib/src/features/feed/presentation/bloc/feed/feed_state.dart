part of 'feed_bloc.dart';

sealed class FeedState extends Equatable {
  const FeedState();

  @override
  List<Object> get props => [];
}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  const FeedLoaded({this.posts = const <Post>[]});
  final List<Post> posts;
  @override
  List<Object> get props => [posts];
}
