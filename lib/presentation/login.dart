import 'package:flutter/material.dart';
import 'package:robot_dreams_logi/presentation/orders.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _controllerName = TextEditingController();

  void _eventSingIn() {

    String title = '${widget.title}: ${_controllerName.text}';

    // move to orders
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => OrderListPage(title: title)
      )
    );

  }

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title)
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controllerName,
              decoration: const InputDecoration(
                labelText: 'Input your name',
                border: OutlineInputBorder()
              )
            )
          ],
        )
      ),
      floatingActionButton: ElevatedButton (
        onPressed: _eventSingIn,
        child: const Text('Sing in')
      )
    );
  }
}