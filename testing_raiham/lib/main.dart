import 'package:flutter/material.dart';
// import 'package:onboarding/onboarding.dart';
import 'pages/onboarding.dart';

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
            secondaryHeaderColor: const Color(0xff41434D) ,
            primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold, color:Color(0xff41434D)),
            headline6: TextStyle(fontSize: 24.0, color:Color(0xff41434D)),
            bodyText2: TextStyle(fontSize: 18.0, color:Color(0xff41434D)),
            button: TextStyle(fontSize: 16.0, color:Color(0xff41434D)),
            bodyText1: TextStyle(fontSize: 18.0, decoration: TextDecoration.underline, color:Color(0xff41434D)), // clickable text!
          ),
        ),
        home: OnboardingPage(),
      );
  // final onboardingPagesList = [
  //   PageModel(
  //     widget: Column(
  //       children: [
  //         Container(
  //             padding: EdgeInsets.only(bottom: 45.0),
  //             child: Image(image: AssetImage('img/initiallog.jpg'))),
  //         Container(
  //             width: double.infinity,
  //             child: Text('Speak to a Listening Pal or Become One',
  //                 style: pageTitleStyle)),
  //         Container(
  //           width: double.infinity,
  //           child: Text(
  //             'Became a healthier and happier YOU',
  //             style: pageInfoStyle,
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  //   PageModel(
  //     widget: Column(
  //       children: [
  //         Padding(padding: EdgeInsets.only(bottom: 45.0)),
  //         Image(image: AssetImage('img/people.jpg')),
  //         // attribution <a href="https://www.flaticon.com/free-icons/people" title="people icons">People icons created by Freepik - Flaticon</a>
  //         Text('Share your experiences', style: pageTitleStyle),
  //         Text(
  //           'Peer Support can create a path for better mental health',
  //           style: pageInfoStyle,
  //         )
  //       ],
  //     ),
  //   ),
  //   PageModel(
  //     widget: Column(
  //       children: [
  //         Image(image: AssetImage('img/initiallog.jpg')),
  //         Text('Sign Up Today', style: pageTitleStyle),
  //         Text(
  //           'In just a few easy steps you can make a change',
  //           style: pageInfoStyle,
  //         ),
  //       ],
  //     ),
  //   ),
  // ];

  // @override
  // Widget build(BuildContext context) {
  //   Color logoColor = const Color.fromRGBO(249, 249, 249, 0);
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Listening Pal Test',
  //     theme: ThemeData(
  //       scaffoldBackgroundColor: const Color.fromRGBO(249, 249, 249, 0),
  //       primaryColor: Colors.blue,
  //       visualDensity: VisualDensity.adaptivePlatformDensity,
  //     ),
  //     home: Onboarding(
  //       proceedButtonStyle: ProceedButtonStyle(
  //         proceedButtonRoute: (context) {
  //           return Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => Container(),
  //             ),
  //             (route) => false,
  //           );
  //         },
  //       ),
  //       // isSkippable = true,

  //       pages: onboardingPagesList,
  //       indicator: Indicator(
  //         indicatorDesign: IndicatorDesign.line(
  //           lineDesign: LineDesign(
  //             lineType: DesignType.line_uniform,
  //           ),
  //         ),
  //       ),
  //       //-------------Other properties--------------
  //       //Color background,
  //       //EdgeInsets pagesContentPadding
  //       //EdgeInsets titleAndInfoPadding
  //       //EdgeInsets footerPadding
  //       //SkipButtonStyle skipButtonStyle
  //     ),
  //   );
  // }
}