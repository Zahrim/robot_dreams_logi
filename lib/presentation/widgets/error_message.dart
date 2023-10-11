import 'package:flutter/cupertino.dart';

class ErrorMessage extends StatelessWidget {
  
  final String message;
  final String title;
  
  const ErrorMessage({super.key, required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        CupertinoDialogAction(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          }
        )
      ]
    );
  }
  
  
}