import 'package:flutter/material.dart';

class PickUpScreen extends StatefulWidget {
  final String title;

  const PickUpScreen({super.key, required this.title});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
