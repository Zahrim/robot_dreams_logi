import 'package:flutter/cupertino.dart';
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
    showCupertinoModalPopup(
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
          CupertinoPageRoute(
            builder: (context) => OrderListPage(title: strTitle),
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
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoTextField(
                    controller: _controllerEmail,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    placeholder: 'Email',
                    decoration: BoxDecoration(
                      color: CupertinoColors.extraLightBackgroundGray,
                      border: Border.all(
                        color: CupertinoColors.lightBackgroundGray,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CupertinoTextField(
                    controller: _controllerPassword,
                    placeholder: 'Password',
                    obscureText: true,
                    obscuringCharacter: '*',
                    decoration: BoxDecoration(
                      color: CupertinoColors.extraLightBackgroundGray,
                      border: Border.all(
                        color: CupertinoColors.lightBackgroundGray,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
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
                  CupertinoButton(
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