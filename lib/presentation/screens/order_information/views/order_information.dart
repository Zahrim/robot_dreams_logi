import 'package:flutter/material.dart';

class OrderInformationScreen extends StatefulWidget {
  final String title;

  const OrderInformationScreen({super.key, required this.title});

  @override
  State<OrderInformationScreen> createState() => _OrderInformationScreenState();
}

class _OrderInformationScreenState extends State<OrderInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
