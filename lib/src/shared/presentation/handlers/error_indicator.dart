
import 'package:flutter/material.dart';

import '../../../config/res_string.dart';

class ErrorIndicator extends StatelessWidget {
  final String errorText;
  const ErrorIndicator({super.key, required this.errorText});

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      backgroundColor: Colors.white,
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
      title: Text(
              ResString.error,
              style: appTextTheme.bodyLarge!.copyWith(color: Colors.black),
            ),
      content: Text(errorText, style: appTextTheme.bodyMedium!.copyWith(color: Colors.black),),
      actions: [
        ElevatedButton(
          child: Text(
            ResString.ok,
            style: appTextTheme.bodyMedium!.copyWith(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );}
}


