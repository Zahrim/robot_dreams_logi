import 'package:flutter/cupertino.dart';
import 'package:robot_dreams_logi/presentation/screens/auth/auth.dart';

class Application extends StatelessWidget {

  final String _title = 'Logi';
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: _title,
      /*theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true
      ),*/
      home: LoginScreen(title: _title),
    );

  }
}