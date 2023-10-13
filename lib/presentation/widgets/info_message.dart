import 'package:flutter/material.dart';

class InfoMessage extends StatelessWidget {
  final String message;
  final String title;

  const InfoMessage({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(title: Text(title), content: Text(message), actions: [
      TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
  }
}
