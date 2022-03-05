import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import './home.dart';

import 'package:url_launcher/url_launcher.dart';

class ResourcesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
        backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
                onPressed: ()=> goHome(context),
                icon:       const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color:  Color(0xff41434D),
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
            ),
          TextButton(
              onPressed: ()=> goHome(context),
              child: Text('Back',
            style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText2),
          ))
          ],
        )
    ),
    body: Padding(padding:EdgeInsets.fromLTRB(10, 0, 10, 0) ,
        child: Column( mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
        child: Column(  mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
          children: [ Text(
            'Resources',
            style: GoogleFonts.dongle( textStyle:Theme.of(context).textTheme.headline1),
          ), Text(
            'If in an immediate emergency, call 911.',
            style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText2),
          ),],)),
       Text(
        'National Resources',
        style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.headline6),
      ),
      Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
        child: Column(  mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
            child:
            RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: 'Text ',
                  style:Theme.of(context).textTheme.bodyText2),
              TextSpan(
                  text: 'HOME to 741741',
                  style: Theme.of(context).textTheme.bodyText1,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launchURL('tel:741741'); //TODO this is broken, need to make it a real SMS handler. May be goofy for iOS
                    }),
              TextSpan(
                  text: ' to reach the Crisis Textline',
                  style:Theme.of(context).textTheme.bodyText2),
            ]),
          ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              child:
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Call ',
                      style:Theme.of(context).textTheme.bodyText2),
                  TextSpan(
                      text: '1-800-273-TALK (8255)',
                      style: Theme.of(context).textTheme.bodyText1,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchURL('tel:1-800-273'); //TODO this is broken, need to make it a real phone call handler. May be goofy for iOS
                        }),
                  TextSpan(
                      text: ' to reach a 24-hour crisis center.',
                      style:Theme.of(context).textTheme.bodyText2),
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              child:
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'National Alliance on Mental Illness (NAMI)',
                      style: Theme.of(context).textTheme.bodyText1,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchURL('https://www.nami.org/home?gclid=Cj0KCQiAgP6PBhDmARIsAPWMq6k6T8rioc-TWF9lE4mCPGTP9J_CQjkyu2lwHPDIf38DS_vWhJncV84aAmAcEALw_wcB'); //TODO this is broken, need to make it a real phone call handler. May be goofy for iOS
                        })
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              child:
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'National Institute of Mental Health (NIMH)',
                      style: Theme.of(context).textTheme.bodyText1,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchURL('https://www.nimh.nih.gov/health/find-help'); //TODO this is broken, need to make it a real phone call handler. May be goofy for iOS
                        })
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              child:
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Substance Abuse and Mental Health Services Administration (SAMHSA)',
                      style: Theme.of(context).textTheme.bodyText1,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchURL('https://findtreatment.samhsa.gov/'); //TODO this is broken, need to make it a real phone call handler. May be goofy for iOS
                        })
                ]),
              ),
            ),
            // Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
            //   child:
            //   RichText(
            //     text: TextSpan(children: [
            //       TextSpan(
            //           text: '211',
            //           style: Theme.of(context).textTheme.bodyText1,
            //           recognizer: TapGestureRecognizer()
            //             ..onTap = () {
            //               launchURL('https://www.211.org/'); //TODO this is broken, need to make it a real phone call handler. May be goofy for iOS
            //             })
            //     ]),
            //   ),
            // ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              child:
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Psychology Today',
                      style: Theme.of(context).textTheme.bodyText1,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchURL('https://www.psychologytoday.com/us/therapists'); //TODO this is broken, need to make it a real phone call handler. May be goofy for iOS
                        })
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              child:
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'DV Hotline',
                      style: Theme.of(context).textTheme.bodyText1,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchURL('https://www.thehotline.org/'); //TODO this is broken, need to make it a real phone call handler. May be goofy for iOS
                        })
                ]),
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
              child:
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Neda',
                      style: Theme.of(context).textTheme.bodyText1,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchURL('https://www.nationaleatingdisorders.org/help-support'); //TODO this is broken, need to make it a real phone call handler. May be goofy for iOS
                        })
                ]),
              ),
            ),
          // TODO: Make this work, but this is how lines work
          // CustomPaint( // Makes a line
          //   size: Size(1 , 1),
          //   painter: MyPainter(),
          // ),
          ],
        ),
      ),
      ],
        ),
    ),
  );

  void goHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => HomePage()),
  );

  void launchURL(url) async {
    if (!await launch(url)) throw 'Could not launch $url';
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const p1 = Offset(0, 50);
    const p2 = Offset(370, 50);
    final paint = Paint()
      ..color = const Color(0xffC7C8CF)
      ..strokeWidth = 1;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}