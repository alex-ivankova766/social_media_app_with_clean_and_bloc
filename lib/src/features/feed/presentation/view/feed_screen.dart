import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_router/routes/modals/modals.dart';
import '../../../../config/app_router/routes/without_nav_bar/index.dart';
import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/presentation/widgets/widgets.dart';
import '../bloc/feed/feed_bloc.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Post> posts = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FeedBloc, FeedState>(
        listener: (context, state) {
          if (state is FeedLoading) {
            _showLoading(context);
          }
          if (state is FeedFailure) {
            _tryHideLoading(context);
            ErrorDialogRoute(state.errorText).pushReplacement(context);
          }
          if (state is FeedLoaded) {
            _tryHideLoading(context);
            setState(() {
              posts = state.posts;
            });
          }
        },
        child: PageView(
            scrollDirection: Axis.vertical,
            children: posts
                .map((post) => VideoPost(
                      assetPath: post.assetPath,
                      isPlaying: true,
                      username: post.user.username.value,
                      caption: post.caption,
                    ))
                .toList()),
      ),
    );
  }

  void _tryHideLoading(BuildContext context) {
    if (isLoading) {
      LoadingDialog.hide(context);
      isLoading = false;
    }
  }

  void _showLoading(BuildContext context) {
    if (!isLoading) {
      LoadingDialog.show(context);
      isLoading = true;
    }
  }
}
