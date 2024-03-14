import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/features/feed/presentation/bloc/discover/discover_bloc.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Discover')),
      bottomNavigationBar: const CustomNavBar(),
      body: BlocBuilder<DiscoverBloc, DiscoverState>(
        builder: (context, state) {
          if (state is DiscoverLoading) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
          if (state is DiscoverLoaded) {
            return const Center(child: Text('Done'));
          } else {
            return const Center(child: Text('Something went wrong'));
          }
        },
      ),
    );
  }
}
