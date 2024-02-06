import 'package:flutter/material.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/config/app_theme.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/shared/presentation/widgets/custom_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social media application',
      theme: CustomTheme().theme(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Application')),
      body: const Center(child: Text('Development has begun')),
      bottomNavigationBar: const CustomNavBar(),
    );
  }
}
