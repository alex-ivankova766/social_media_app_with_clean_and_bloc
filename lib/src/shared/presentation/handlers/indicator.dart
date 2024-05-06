import 'package:flutter/material.dart';

mixin ModalsHandler {

  static final loading =
    AlertDialog(
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      content: Center(child:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.grey,
        ),
        width: 100.0,
        height: 100.0,
        child: const Center(child: SizedBox(height: 50, width: 50,child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3,)),)
      ),)
  );
  

  Future<void> showError(BuildContext context, {required String errorText}) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
        AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      titlePadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
      actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      backgroundColor: Colors.white,
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
      title: const Text(
              'Error',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
      content: Text(errorText),
      actions: [
        ElevatedButton(
          child: const Text(
            'Ok',
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
    );
  }
}
