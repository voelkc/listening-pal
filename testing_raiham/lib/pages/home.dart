import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import './onboarding.dart';
import './resourcespage.dart';
import './callpage.dart';
import './appointments.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
<<<<<<< HEAD
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  onPressed: () => goToResources(context),
                  icon: const Icon(
                    Icons.folder,
                    color: Color(0xff41434D),
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Color(0xff41434D),
                  size: 30.0,
                ),
              ],
            )),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hey, pal!',
                              //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                              style: GoogleFonts.dongle(
                                  textStyle:
                                      Theme.of(context).textTheme.headline1),
                            ),
                            Text(
                              'You have X credits available',
                              //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                          ]),
                      ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xffF9F9F9)),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        width: 2.5,
                                        color: Color(0xff95D4D8))))),
                        onPressed: () => goToOnBoarding(context),
                        child: Text(
                          'Purchase Credits',
                          style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.button),
                        ),
                      ),
                    ]),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(149, 212, 216, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Color(0xff95D4D8))))),
                  onPressed: () => goToApptPage(context),
                  child: Text(
                    'Schedule an Appointment',
                    style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.button),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Today',
                          //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          style: GoogleFonts.dongle(
                              textStyle: Theme.of(context).textTheme.headline1),
                        ),
                        Text(
                          'No appointments scheduled today',
                          //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.bodyText2),
                        ),
                        ElevatedButton(
                          //TODO: REMOVE FOR TESTING ONLY, should replace with stateful widget
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromRGBO(149, 212, 216, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: Color(0xff41434D))))),
                          onPressed: () => goToCall(context),
                          child: Text(
                            'Call',
                            style: GoogleFonts.roboto(
                                textStyle: Theme.of(context).textTheme.button),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'This Month',
                              //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                              style: GoogleFonts.dongle(
                                  textStyle:
                                      Theme.of(context).textTheme.headline1),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(120, 0, 0, 0),
                              child: const Icon(
                                Icons.calendar_month_rounded,
                                color: Color(0xff41434D),
                                size: 30.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                            )
                          ],
                        ),
                        Text(
                          'No upcoming appointments this month',
                          //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.bodyText2),
                        ),
                      ],
                    ),
                  ],
=======
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => goToResources(context),
                child: Text('Resources',
                  style: GoogleFonts.roboto(textStyle:Theme.of(context).textTheme.bodyText1).copyWith(decoration: TextDecoration.none),
                ),
              ),
              TextButton(
                onPressed: () => goToResources(context),
                child: Text('Account',
                  style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText1).copyWith(decoration: TextDecoration.none),
                ),
              ),
            ],
          )
        ),
        body: Stack(children: [
          Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), child:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(
                      'Hey, pal!',
                      //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      style: GoogleFonts.dongle( textStyle:Theme.of(context).textTheme.headline1),
                    ),
                    ]),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ Text(
                      'You have X credits available',
                      //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText2),
                    ),
                      ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xffF9F9F9)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        width: 2.5,
                                        color: Color(0xff95D4D8))))),
                        onPressed: () => launchURL('https://listeningpal.com/'),
                        child: Text('Get Credits',
                          style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),),
                      ),
                    ]),
              ]),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(149, 212, 216, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Color(0xff95D4D8))))),
                  onPressed: () => goToOnBoarding(context),
                  child: Text('Schedule an Appointment', style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [Column (mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(
                      'Today',
                      //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      style: GoogleFonts.dongle( textStyle:Theme.of(context).textTheme.headline1),
                    ), Text(
                      'No appointments scheduled today',
                      //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText2),
                    ),
                      ElevatedButton( //TODO: REMOVE FOR TESTING ONLY, should replace with stateful widget
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromRGBO(149, 212, 216, 1)),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: Color(0xff95D4D8))))),
                        onPressed: () =>  _presentOverlay('Jane|March 21, 2022|3:30 - 4:00pm'),
                        child: Text('Call', style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),),
                      ),
                    ],),],
                ),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [Column (mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ Flex (direction: Axis.horizontal, mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text(
                        'This Month',
                        //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                        style: GoogleFonts.dongle( textStyle:Theme.of(context).textTheme.headline1),
                      ),
                      const Padding(padding: EdgeInsets.fromLTRB(120, 0, 0, 0), child: Icon(
                        Icons.calendar_month_rounded,
                        color:  Color(0xff41434D),
                        size: 30.0,
                        semanticLabel: 'Text to announce in accessibility modes',
                      ),)
                    ],),
                      Text(
                        'No upcoming appointments this month',
                        //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                        style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText2),
                      ),
                    ],),],
>>>>>>> b7a63b35f00097132ba07b2bcdd5c7c1887c9559
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(149, 212, 216, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
<<<<<<< HEAD
                              side: BorderSide(color: Color(0xff95D4D8))))),
                  onPressed: () => goToOnBoarding(context),
                  child: Text(
                    'Go Back',
                    style: GoogleFonts.roboto(
                        textStyle: Theme.of(context).textTheme.button),
                  ),
                ),
              ], // Chillen
            ),
          ),
=======
                              side: const BorderSide(
                                  color: Color(0xff95D4D8))))),
                  onPressed: () => goToOnBoarding(context),
                  child: Text('Go Back', style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),),
                ),
              ], // Chillen
            ),
            ),
          OverlayView(key: UniqueKey()),
        ], //Stack children
>>>>>>> b7a63b35f00097132ba07b2bcdd5c7c1887c9559
        ),
      );

  void goToCall(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => CallPage()),
      );

  void goToOnBoarding(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnboardingPage()),
      );

  void goToResources(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ResourcesPage()),
      );
  void goToApptPage(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => ApptPage()),
      );
}

// Overlay Control stuff
// Should add one for each type (Join call, End Call, Cancel Appointment)
class OverlayView extends StatelessWidget {
  const OverlayView({
    required Key key,
  }) : super(key: key);

  // @override
  // State<StatefulWidget> createState() {
  //   // TODO: implement createState
  //   throw UnimplementedError();
  // }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: Loader.appLoader.loaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return overlay(context);
        } else {
          return Container();
        }
      },
    );
  }

  Container overlay(context) {
    return Container(
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Row(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: const Color(0xff41434D),
                  child: Padding( padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child:Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close_outlined, color: Color(0xffF9F9F9),),
                            onPressed: () => _hideOverlay(),
                          ),
                        ],
                      ),
                      Text('Today',
                        style: GoogleFonts.dongle( textStyle:Theme.of(context)
                            .textTheme.headline1,)
                            .copyWith(color: Theme.of(context).scaffoldBackgroundColor, fontSize: 48)
                      ),
                      ValueListenableBuilder<String>(
                        builder: (context, value, child) {
                          return Text(value.split('|')[1], style: GoogleFonts.roboto(
                            textStyle:Theme.of(context).textTheme.bodyText2,)
                              .copyWith(color: Theme.of(context).scaffoldBackgroundColor),);
                        },
                        valueListenable:
                        Loader.appLoader.loaderTextNotifier,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                const Icon(Icons.person_outline_rounded, color: Color(0xffF9F9F9),),
                                const SizedBox(
                                  width: 10,
                                ),
                                ValueListenableBuilder<String>(
                                  builder: (context, value, child) {
                                    return Text('Call with ' + value.split('|')[0], style: GoogleFonts.roboto(
                                      textStyle:Theme.of(context).textTheme.bodyText2,
                                    ).copyWith(color: Theme.of(context).scaffoldBackgroundColor,
                                    fontSize: 18),);
                                  },
                                  valueListenable:
                                  Loader.appLoader.loaderTextNotifier,
                                ),
                          ]),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                              children:[
                                const Icon(Icons.access_time, color: Color(0xffF9F9F9),),
                                const SizedBox(
                                  width: 10,
                                ),
                                ValueListenableBuilder<String>(
                                  builder: (context, value, child) {
                                    return Text('at ' + value.split('|')[2], style: GoogleFonts.roboto(
                                      textStyle:Theme.of(context).textTheme.bodyText2,
                                    ).copyWith(color: Theme.of(context).scaffoldBackgroundColor,
                                      fontSize: 18),);
                                  },
                                  valueListenable:
                                  Loader.appLoader.loaderTextNotifier,
                                ),
                              ]),
                          Padding(padding: const EdgeInsets.fromLTRB(3, 20, 25, 0),
                            child: Text(
                              'By joining this call, I agree to the terms of service. If you are experiencing crisis, hang up and call 911 or go to the nearest emergency room or call 1-800-273-TALK',
                            style: GoogleFonts.roboto(textStyle:Theme.of(context).textTheme.bodyText2,)
                                .copyWith(fontStyle: FontStyle.italic,
                                color: Theme.of(context).scaffoldBackgroundColor,
                                fontSize: 15)),
                          ),
                          const SizedBox(height: 24),
                          Row( mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Theme( // Fuck this, so annoying just to change the color of the check box
                                data: Theme.of(context).copyWith(
                                  unselectedWidgetColor: Colors.white,
                                ),
                                child: Checkbox(value: false, activeColor: Colors.white, checkColor: Colors.white, onChanged: (bool? value) {
                                  // setState(() {
                                  //   isChecked = value!;)
                                }),
                              ),
                              Text('I agree to the terms of service.',
                                style:GoogleFonts.roboto(textStyle: Theme.of(context).textTheme.bodyText2).copyWith(color: Theme.of(context).scaffoldBackgroundColor
      ),)
                            ],),
                          Padding(padding: const EdgeInsets.fromLTRB(0, 20, 30, 0),
                            child: ElevatedButton(
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(0),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    const Color.fromRGBO(149, 212, 216, 1)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: const BorderSide(
                                            color: Color(0xff95D4D8))))),
                            onPressed: () => {_hideOverlay(), goToCall(context)},
                            child: Padding(padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Text('Join Now',
                              style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),
                            ),
                            ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      )
                    ],
                  ),
        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Loader {
  static final Loader appLoader = Loader(); //singleton
  ValueNotifier<bool> loaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> loaderTextNotifier = ValueNotifier('message');

  void showLoader() {
  loaderShowingNotifier.value = true;
  }

  void hideLoader() {
  loaderShowingNotifier.value = false;
  }

  void setText({String errorMessage = 'default'}) {
  loaderTextNotifier.value = errorMessage;
  }

  void setImage() {
    // same as that of setText //
  }
}

void _presentOverlay(message) async {
  Loader.appLoader.showLoader();
  Loader.appLoader.setText(errorMessage: message);
  // await Future.delayed(Duration(seconds: 5)); // Hide it after 5 seconds for testing
  // Loader.appLoader.hideLoader();
}

void _hideOverlay() async {
  Loader.appLoader.hideLoader();
}

void goToCall(context) => Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (_) => CallPage()),
);

void launchURL(url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}