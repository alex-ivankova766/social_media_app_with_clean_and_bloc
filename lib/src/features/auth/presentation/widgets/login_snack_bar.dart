import 'package:flutter/material.dart';

SnackBar authSnackBar(String text) {
  return SnackBar(
    animation: CurvedAnimation(
        parent: kAlwaysCompleteAnimation, curve: Curves.easeInOut),
    padding: const EdgeInsets.all(0),
    content: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 80, 79, 79),
        Color.fromARGB(255, 41, 40, 40)
      ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(text),
      ),
    ),
  );
}
