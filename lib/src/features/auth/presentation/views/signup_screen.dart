import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign up')),
      body: const Center(child: Text('Development has begun')),
      // bottomNavigationBar: const CustomNavBar(),
    );
  }
}
