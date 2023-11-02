import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  final String title;

  const LocationScreen({super.key, required this.title});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
