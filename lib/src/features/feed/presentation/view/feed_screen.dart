import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../bloc/feed/feed_bloc.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeedBloc>().add(FeedGetPosts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
        return PageView(
            scrollDirection: Axis.vertical,
            children: state.posts
                .map((post) => VideoPost(
                      assetPath: post.assetPath,
                      isPlaying: true,
                      username: post.user.username.value,
                      caption: post.caption,
                    ))
                .toList());
      }),
    );
  }
}
