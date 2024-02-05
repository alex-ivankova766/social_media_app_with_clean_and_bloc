import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social media application',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const Scaffold(body: Center(child: Text('Development has begun'))),
    );
  }
}
