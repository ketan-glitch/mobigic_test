import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobigic_test/views/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

Color primaryColor = const Color(0xFF941f37);
const Color textPrimary = Color(0xff000000);
const Color textSecondary = Color(0xff838383);

Map<int, Color> color = const {
  50: Color.fromRGBO(147, 31, 56, .1),
  100: Color.fromRGBO(147, 31, 56, .2),
  200: Color.fromRGBO(147, 31, 56, .3),
  300: Color.fromRGBO(147, 31, 56, .4),
  400: Color.fromRGBO(147, 31, 56, .5),
  500: Color.fromRGBO(147, 31, 56, .6),
  600: Color.fromRGBO(147, 31, 56, .7),
  700: Color.fromRGBO(147, 31, 56, .8),
  800: Color.fromRGBO(147, 31, 56, .9),
  900: Color.fromRGBO(147, 31, 56, 1.0),
};
MaterialColor colorCustom = MaterialColor(0xFF941f37, color);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobigic Test',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: colorCustom,
        primaryColor: primaryColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          actionsIconTheme: IconThemeData(
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          // systemOverlayStyle: const SystemUiOverlayStyle(
          //   // Status bar color
          //   statusBarColor: Colors.white,
          //   // Status bar brightness (optional)
          //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          //   statusBarBrightness: Brightness.light, // For iOS (dark icons)
          // ),
        ),
        textTheme: TextTheme(
          button: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
            color: textSecondary,
            fontSize: 14.0,
          ),
          subtitle1: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
          bodyText1: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
          ),
          bodyText2: GoogleFonts.montserrat(
            fontWeight: FontWeight.w400,
          ),
          headline1: GoogleFonts.montserrat(),
          headline2: GoogleFonts.montserrat(),
          headline3: GoogleFonts.montserrat(),
          headline4: GoogleFonts.montserrat(),
          headline5: GoogleFonts.montserrat(),
          headline6: GoogleFonts.montserrat(),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
