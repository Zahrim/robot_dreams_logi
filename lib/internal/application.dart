import 'package:flutter/material.dart';
import 'package:robot_dreams_logi/presentation/screens/auth/auth.dart';
import 'package:robot_dreams_logi/presentation/screens/order_list/order_list.dart';

class Application extends StatelessWidget {

  final String _title = 'Logi';
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      /*theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true
      ),*/
      home: LoginScreen(title: _title),
      //home: OrderListScreen(title: _title),
    );

  }
}