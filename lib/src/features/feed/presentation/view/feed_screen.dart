import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/widgets.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: const Center(child: Text('Development has begun')),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
