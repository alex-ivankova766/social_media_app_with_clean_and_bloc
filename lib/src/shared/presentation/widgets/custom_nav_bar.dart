import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 10,
      color: Colors.black,
      child: SizedBox(
        height: 75,
        child: Row(children: [
          IconButton(
              onPressed: () {}, iconSize: 30, icon: const Icon(Icons.home)),
          IconButton(
              onPressed: () {}, iconSize: 30, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {},
              iconSize: 30,
              icon: const Icon(Icons.add_circle)),
          IconButton(
              onPressed: () {}, iconSize: 30, icon: const Icon(Icons.message)),
          IconButton(
              onPressed: () {}, iconSize: 30, icon: const Icon(Icons.person)),
        ]),
      ),
    );
  }
}
