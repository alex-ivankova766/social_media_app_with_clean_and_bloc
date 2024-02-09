import 'package:flutter/material.dart';

import 'src/config/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Social media application',
      theme: CustomTheme().theme(),
      routerConfig: AppRouter().router,
    );
  }
}
