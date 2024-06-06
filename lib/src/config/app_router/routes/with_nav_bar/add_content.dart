import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../features/content/domain/usecases/usecases.dart';
import '../../../../features/content/presentation/cubit/add_content_cubit.dart';
import '../../../../features/content/presentation/view/screens.dart';
import '../../../../features/feed/data/repositories/repositories.dart';

@immutable
class AddContentRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BlocProvider(
      create: (context) => AddContentCubit(
          createPost: CreatePost(context.read<PostRepositoryImpl>())),
      child: const AddContentScreen(),
    );
  }
}
