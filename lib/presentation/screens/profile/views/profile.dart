import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_dreams_logi/config/settings.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.title});

  final String title;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final settings = context.watch<Settings>();

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${AppLocalizations.of(context)?.black_theme} '),
                  const SizedBox(
                    height: 10,
                  ),
                  Switch(
                      value: settings.isThemeBlack,
                      onChanged: (value) {
                        settings.setTheme(value);
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      settings.setLocale('en');
                    },
                    child: const Text('English'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                    onPressed: () {
                      settings.setLocale('uk');
                    },
                    child: const Text('Український'),
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
