import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/presentation/handlers/loading_indicator.dart';
import '../../../../shared/presentation/widgets/widgets.dart';
import '../bloc/feed/feed_bloc.dart';

class FeedScreen extends StatefulWidget{
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<Post> posts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomNavBar(),
      body: BlocListener<FeedBloc, FeedState>(
        listener: (context, state) {
          if (state is FeedLoading) {
            context.pushNamed('loading_indicator');
            }
            if (state is FeedFailure) {
              context.pushNamed('error', pathParameters: {"error_text":state.errorText});
            }
            if (state is FeedLoaded) {
              setState(() {
                posts = state.posts;
              });
              
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            }
          }},
        child:
             PageView(
              scrollDirection: Axis.vertical,
              children: posts
                  .map((post) => VideoPost(assetPath: post.assetPath, isPlaying: true,username: post.user.username.value,
                        caption: post.caption,) )
                  .toList()),
            
         
      ),
    );
  }
}
