import 'package:flutter/material.dart';

class DriverInformationScreen extends StatefulWidget {
  final String title;

  const DriverInformationScreen({super.key, required this.title});

  @override
  State<DriverInformationScreen> createState() => _DriverInformationScreenState();
}

class _DriverInformationScreenState extends State<DriverInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
