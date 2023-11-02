import 'package:flutter/material.dart';

class RouteScreen extends StatefulWidget {
  final String title;

  const RouteScreen({super.key, required this.title});

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
    );
  }
}
