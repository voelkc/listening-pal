import 'package:flutter/material.dart';
import 'package:testing_raiham/pages/appointments.dart';
import 'package:testing_raiham/pages/home.dart';
import 'package:onboarding/onboarding.dart';
import 'pages/onboarding.dart';
import './pages/updatedappts.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String title = 'ListeningPal';
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffF9F9F9),
          primaryColor: const Color.fromRGBO(149, 212, 216, 1),
          secondaryHeaderColor: const Color(0xff41434D),
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontSize: 64.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff41434D)),
            headline6: TextStyle(fontSize: 24.0, color: Color(0xff41434D)),
            bodyText2: TextStyle(fontSize: 18.0, color: Color(0xff41434D)),
            button: TextStyle(fontSize: 16.0, color: Color(0xff41434D)),
            bodyText1: TextStyle(
                fontSize: 18.0,
                decoration: TextDecoration.underline,
                color: Color(0xff41434D)), // clickable text!
          ),
        ),
        home: OnboardingPage(),
      );
}
