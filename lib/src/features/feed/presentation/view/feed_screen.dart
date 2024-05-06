import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/feed/feed_bloc.dart';
import '../../../../shared/presentation/handlers/indicator.dart';

import '../../../../shared/presentation/widgets/widgets.dart';
import '../bloc/feed/feed_bloc.dart';

class FeedScreen extends StatelessWidget{
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<FeedBloc, FeedState>(
        builder: (context, state) {
          if (state is FeedLoading) {
            return ModalsHandler.loading;
          }
          if (state is FeedLoaded) {
            return PageView(
              scrollDirection: Axis.vertical,
              children: state.posts
                  .map((post) => VideoPost(assetPath: post.assetPath, isPlaying: true,username: post.user.username.value,
                        caption: post.caption,) )
                  .toList(),
            );
          }
          return Container(color:Colors.white);
        },
      ),
    );
  }
}
