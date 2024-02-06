import 'package:flutter/material.dart';
import 'package:social_media_app_with_clean_architecture_and_the_bloc_pattern/src/config/app_theme.dart';

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
      home: const Scaffold(body: Center(child: Text('Development has begun'))),
    );
  }
}
