import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/domain/entities/entities.dart';
import '../../../../shared/presentation/widgets/widgets.dart';
import '../bloc/discover/discover_bloc.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover')),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocListener<DiscoverBloc, DiscoverState>(
          listener: (context, state) {
            if (state is DiscoverLoading) {
              context.pushNamed('loading_indicator');
            }
            if (state is DiscoverFailure) {
              context.pushNamed('error',
                  pathParameters: {"error_text": state.errorText});
            }
            if (state is DiscoverLoaded) {
              setState(() {
                users = state.users;
              });
              if (GoRouter.of(context).canPop()) {
                GoRouter.of(context).pop();
              }
            }
          },
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            itemCount: users.length,
            itemBuilder: (context, index) {
              User user = users[index];
              return _DiscoverUserCard(
                user: user,
                index: index,
              );
            },
          )),
    );
  }
}

class _DiscoverUserCard extends StatelessWidget {
  const _DiscoverUserCard({
    required this.user,
    required this.index,
  });
  final int index;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: (index == 0) ? 250 : 300,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: user.imagePath == null
                      ? const AssetImage('assets/images_1.jpg')
                      : AssetImage(user.imagePath!))),
        ),
        const CustomGradientOverlay(
          stops: [0.4, 1.0],
          colors: [Colors.transparent, Colors.black],
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            CircleAvatar(
              backgroundImage:
                  (user.imagePath == null) ? null : AssetImage(user.imagePath!),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              user.username.value,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ]),
        )
      ],
    );
  }
}
