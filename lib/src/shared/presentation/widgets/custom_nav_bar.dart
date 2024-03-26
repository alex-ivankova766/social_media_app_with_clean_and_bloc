import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/blocs/auth/auth_bloc.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 10,
      color: Colors.black,
      child: SizedBox(
        height: 75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  context.goNamed('feed');
                },
                iconSize: 30,
                icon: const Icon(Icons.home)),
            IconButton(
                onPressed: () {
                  context.goNamed('discover');
                },
                iconSize: 30,
                icon: const Icon(Icons.search)),
            IconButton(
                onPressed: () {
                  context.goNamed('add_content');
                },
                iconSize: 30,
                icon: const Icon(Icons.add_circle)),
            IconButton(
                onPressed: () {
                  // context.goNamed('feed');
                },
                iconSize: 30,
                icon: const Icon(Icons.message)),
            IconButton(
                onPressed: () {
                  // context.goNamed('discover');
                },
                iconSize: 30,
                icon: const Icon(Icons.person)),
            IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(AuthLogoutUser());
                },
                iconSize: 30,
                icon: const Icon(Icons.logout)),
            // icon: const Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}
