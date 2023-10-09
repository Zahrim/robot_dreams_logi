import 'package:flutter/material.dart';
import 'package:robot_dreams_logi/presentation/login.dart';

class Application extends StatelessWidget {
  final String _title = 'Logi';

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true
      ),
      home: LoginPage(title: _title),
    );

  }
}