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
    ThemeData baseTheme =
        (settings.isThemeBlack) ? ThemeData.dark() : ThemeData.light();

    ThemeData customTheme = baseTheme.copyWith(
      textTheme: baseTheme.textTheme.copyWith(
        bodyMedium: baseTheme.textTheme.titleLarge!.copyWith(
          fontFamily: GoogleFonts.nunito().fontFamily,
        ),
        titleLarge: baseTheme.textTheme.titleLarge!.copyWith(
            fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 35),
      ),
    );

    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(settings.currentLocale),
      title: _title,
      theme: customTheme,
      //home: LoginScreen(title: _title),
      home: OrderListScreen(title: _title),
    );
  }
}
