import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import './home.dart';
import './codepage.dart';

void main() {
  runApp(OnboardingPage());
}

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Listening Pal',
              body: 'Easy and accessible support.',

              // image: buildImage('img/initiallog.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Stay anonymous and make a difference',
              body: "Peer to peer mental health helps us all",
              image: buildImage('img/initiallog.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Start supporting today',
              // body: 'Start your journey',
              bodyWidget: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(149, 212, 216, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromRGBO(149, 212, 216, 1))))),
                onPressed: () => goToHome(context),
                child: const Text('Create Account'),
              ),
              footer: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(149, 212, 216, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromRGBO(149, 212, 216, 1))))),
                onPressed: () => goToCodePage(context),
                child: const Text('Enter Verification Code'),
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //       backgroundColor: MaterialStateProperty.all<Color>(
              //           Color.fromRGBO(149, 212, 216, 1)),
              //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              //           RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(18.0),
              //               side: BorderSide(
              //                   color: Color.fromRGBO(149, 212, 216, 1))))),
              //   onPressed: () => goToOnBoarding(context),
              //   child: const Text('Go back'),
              // )

              image: buildImage('img/people.jpg'),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Enter Verification Code',
              body: 'Enter the 5 digit code sent to your phone number',
              image: buildImage('img/digit.png'),
              footer: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromRGBO(149, 212, 216, 1)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(
                                color: Color.fromRGBO(149, 212, 216, 1))))),
                onPressed: () => goToHome(context),
                child: const Text('Continue'),
              ),
              decoration: getPageDecoration(),
            ),
          ],
          done: Text('Start', style: TextStyle(fontWeight: FontWeight.w600)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: Text('Skip'),
          onSkip: () => goToHome(context),
          next: Icon(Icons.arrow_forward),
          dotsDecorator: getDotDecoration(),
          globalBackgroundColor: Theme.of(context).primaryColor,
          skipFlex: 0,
          nextFlex: 0,
          // isProgressTap: false,
          // isProgress: false,
          // showNextButton: false,
          // freeze: true,
          // animationDuration: 1000,
        ),
      );
  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));
  void goToHome(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomePage()),
      );
  void goToCodePage(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => CodePage()),
      );
  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Color(0xFFBDBDBD),
        //activeColor: Colors.orange,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: TextStyle(fontSize: 20),
        descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: EdgeInsets.all(24),
        bodyAlignment: Alignment.center,
        pageColor: Colors.white,
      );
}
