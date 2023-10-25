import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_dreams_logi/presentation/screens/auth/auth.dart';
import 'package:robot_dreams_logi/presentation/screens/order_list/order_list.dart';
import 'package:robot_dreams_logi/config/settings.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Application extends StatelessWidget {
  final String _title = 'Logi';

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<Settings>();

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settings.currentLocale),
      themeMode: (settings.isThemeBlack) ? ThemeMode.dark : ThemeMode.light,
      title: _title,
      theme: ThemeData(
        //useMaterial3: true,
        brightness: Brightness.light,
        textTheme: TextTheme(
          bodyMedium: ThemeData.light().textTheme.bodyMedium!.copyWith(
                fontFamily: GoogleFonts.nunito().fontFamily,
              ),
          titleLarge: ThemeData.light().textTheme.titleLarge!.copyWith(
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 35,
              ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        textTheme: TextTheme(
          bodyMedium: ThemeData.dark().textTheme.bodyMedium!.copyWith(
                fontFamily: GoogleFonts.nunito().fontFamily,
              ),
          titleLarge: ThemeData.dark().textTheme.titleLarge!.copyWith(
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 35,
              ),
        ),
      ),
      //home: LoginScreen(title: _title),
      home: OrderListScreen(
        title: _title,
      ),
    );
  }
}
