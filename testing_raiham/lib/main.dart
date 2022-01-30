import 'package:flutter/material.dart';
import 'package:onboarding/onboarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final onboardingPagesList = [
    PageModel(
      widget: Column(
        children: [
          Container(
              padding: EdgeInsets.only(bottom: 45.0),
              child: Image(image: AssetImage('img/initiallog.jpg'))),
          Container(
              width: double.infinity,
              child: Text('Speak to a Listening Pal or Become One',
                  style: pageTitleStyle)),
          Container(
            width: double.infinity,
            child: Text(
              'Became a healthier and happier YOU',
              style: pageInfoStyle,
            ),
          ),
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Padding(padding: EdgeInsets.only(bottom: 45.0)),
          Image(image: AssetImage('img/people.jpg')),
          // attribution <a href="https://www.flaticon.com/free-icons/people" title="people icons">People icons created by Freepik - Flaticon</a>
          Text('Share your experiences', style: pageTitleStyle),
          Text(
            'Peer Support can create a path for better mental health',
            style: pageInfoStyle,
          )
        ],
      ),
    ),
    PageModel(
      widget: Column(
        children: [
          Image(image: AssetImage('img/initiallog.jpg')),
          Text('Sign Up Today', style: pageTitleStyle),
          Text(
            'In just a few easy steps you can make a change',
            style: pageInfoStyle,
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Color logoColor = const Color.fromRGBO(112, 168, 218, 255);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Listening Pal Test',
      theme: ThemeData(
        backgroundColor: logoColor,
        primaryColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Onboarding(
        proceedButtonStyle: ProceedButtonStyle(
          proceedButtonRoute: (context) {
            return Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Container(),
              ),
              (route) => false,
            );
          },
        ),
        // isSkippable = true,

        pages: onboardingPagesList,
        indicator: Indicator(
          indicatorDesign: IndicatorDesign.line(
            lineDesign: LineDesign(
              lineType: DesignType.line_uniform,
            ),
          ),
        ),
        //-------------Other properties--------------
        //Color background,
        //EdgeInsets pagesContentPadding
        //EdgeInsets titleAndInfoPadding
        //EdgeInsets footerPadding
        //SkipButtonStyle skipButtonStyle
      ),
    );
  }
}
