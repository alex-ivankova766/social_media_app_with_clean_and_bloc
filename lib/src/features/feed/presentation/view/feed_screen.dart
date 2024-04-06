import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/feed/presentation/bloc/feed/feed_bloc.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/shared/presentation/widgets/another_video_player.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
          if (state is FeedLoaded) {
            return PageView(
              scrollDirection: Axis.vertical,
              children: state.posts
                  .map((post) => AnotherVideoPlayer(
                        assetPath: post.assetPath,
                        username: post.user.username.value,
                        caption: post.caption,
                      ))
                  .toList(),
            );
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
