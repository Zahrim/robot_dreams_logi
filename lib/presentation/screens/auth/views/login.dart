import 'package:flutter/material.dart';
import 'package:robot_dreams_logi/presentation/screens/order_list/order_list.dart';
import 'package:robot_dreams_logi/presentation/screens/auth/controller/controller.dart';
import 'package:robot_dreams_logi/domain/models/driver.dart';
import 'package:robot_dreams_logi/presentation/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.title});

  final String title;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  void _showError(String strTitle, String strMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            ErrorMessage(title: strTitle, message: strMessage));
  }

  void _onPressedSingIn() async {
    String strEmail = _controllerEmail.text;
    String strPassword = _controllerPassword.text;

    final List<Driver> lsDiver = await loadDrivers();

    List<Driver> lsDriverResult =
        lsDiver.where((element) => (element.email == strEmail)).toList();

    if (lsDriverResult.isNotEmpty) {
      lsDriverResult =
          lsDiver.where((element) => (element.pass == strPassword)).toList();
      if (lsDriverResult.isNotEmpty) {
        String strTitle = '${widget.title}: ${lsDriverResult[0].name}';
        if (!context.mounted) return;

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => OrderListScreen(title: strTitle),
          ),
        );
      } else {
        _showError("Error", 'Bad password');
      }
    } else {
      _showError("Error", 'Invalid email');
    }
  }

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: _controllerEmail,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      icon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _controllerPassword,
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      icon: Icon(Icons.password_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _onPressedSingIn,
                    child: const Text('Sign in'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
