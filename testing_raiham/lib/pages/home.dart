import 'package:flutter/gestures.dart';
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
                onPressed: () => launchURL('https://listeningpal.com/'),
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
                  onPressed: () => goToApptPage(context),
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
                        onPressed: () =>  _presentJoinOverlay('Jane|March 21, 2022|3:30 - 4:00pm'),
                        child: Text('Call Placeholder', style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),),
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
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(149, 212, 216, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Color(0xff95D4D8))))),
                  onPressed: () => _presentAppointmentDetailsOverlay('Jane|March 21, 2022|3:30 - 4:00pm'),
                  child: Text('Appointment Placeholder', style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all<double>(0),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromRGBO(149, 212, 216, 1)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(
                                  color: Color(0xff95D4D8))))),
                  onPressed: () => goToOnBoarding(context),
                  child: Text('Go Back', style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),),
                ),
              ], // Chillen
            ),
            ),
          JoinOverlayView(key: UniqueKey()),
          EndOverlayView(key: UniqueKey()),
          CancelOverlayView(key: UniqueKey()),
          AppointmentDetailsOverlayView(key: UniqueKey()),
        ], //Stack children
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
class JoinOverlayView extends StatelessWidget {
  const JoinOverlayView({
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
      valueListenable: OverlayLoader.appLoader.joinLoaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return joinOverlay(context);
        } else {
          return Container();
        }
      },
    );
  }

  Container joinOverlay(context) {
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
                            onPressed: () => _hideJoinOverlay(),
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
                        OverlayLoader.appLoader.joinLoaderTextNotifier,
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
                                  OverlayLoader.appLoader.joinLoaderTextNotifier,
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
                                  OverlayLoader.appLoader.joinLoaderTextNotifier,
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
                            onPressed: () async => {_hideJoinOverlay(), _goToCall(context), await Future.delayed(const Duration(seconds: 1)), _presentEndOverlay('text')},
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

class EndOverlayView extends StatelessWidget {
  const EndOverlayView({
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
      valueListenable: OverlayLoader.appLoader.endLoaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return endOverlay(context);
        } else {
          return Container();
        }
      },
    );
  }

  Container endOverlay(context) {
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
                  child: Padding( padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     Spacer(),
                        //     IconButton(
                        //       icon: const Icon(Icons.close_outlined, color: Color(0xffF9F9F9),),
                        //       onPressed: () => _hideEndOverlay(),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 30),
                        Text('Thank you',
                            style: GoogleFonts.dongle( textStyle:Theme.of(context)
                                .textTheme.headline1,)
                                .copyWith(color: Theme.of(context).scaffoldBackgroundColor, fontSize: 48)
                        ),
                        const SizedBox(height: 30),
                        Text('Did something go wrong?',
                            style: GoogleFonts.roboto( textStyle:Theme.of(context)
                                .textTheme.bodyText2,)
                                .copyWith(color: Theme.of(context).scaffoldBackgroundColor)
                        ),
                        const SizedBox(height: 30),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'If so, you can report it ',
                                style: GoogleFonts.roboto( textStyle:Theme.of(context)
                                    .textTheme.bodyText2,)
                                    .copyWith(color: Theme.of(context).scaffoldBackgroundColor)
                            ),
                            TextSpan(
                                text: 'here',
                                style: GoogleFonts.roboto( textStyle:Theme.of(context)
                                    .textTheme.bodyText2,)
                                    .copyWith(color: Theme.of(context).primaryColor, decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    launchURL('tel:741741'); //TODO this is broken, need to make it a real SMS handler. May be goofy for iOS
                                  }),
                          ]),
                        ),
                        const SizedBox(height: 60),
                        Row( mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                              onPressed: () => {_hideEndOverlay()},
                              child: Padding(padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                                child: Text('Done',
                                  style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),
                                ),
                              ),
                            ),
                          ],),

                        const SizedBox(height: 20),
                ]),
              ),
          ),
              ),
            ],),
        ),
      ),
    );
  }
}

class CancelOverlayView extends StatelessWidget {
  const CancelOverlayView({
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
      valueListenable: OverlayLoader.appLoader.cancelLoaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return cancelOverlay(context);
        } else {
          return Container();
        }
      },
    );
  }

  Container cancelOverlay(context) {
    debugPrint(OverlayLoader.appLoader.cancelLoaderTextNotifier.value);
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
                  child: Padding( padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child:Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     Spacer(),
                          //     IconButton(
                          //       icon: const Icon(Icons.close_outlined, color: Color(0xffF9F9F9),),
                          //       onPressed: () => _hideEndOverlay(),
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 30),
                          Text('Confirmation',
                              style: GoogleFonts.dongle( textStyle:Theme.of(context)
                                  .textTheme.headline1,)
                                  .copyWith(color: Theme.of(context).scaffoldBackgroundColor, fontSize: 48)
                          ),
                          const SizedBox(height: 30),
                          ValueListenableBuilder<String>(
                            builder: (context, value, child) {
                              return Text('Are you sure you want to cancel your appointment on ' + value.split('|')[1], style: GoogleFonts.roboto(
                                textStyle:Theme.of(context).textTheme.bodyText2,
                              ).copyWith(color: Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 18),);
                            },
                            valueListenable:
                            OverlayLoader.appLoader.cancelLoaderTextNotifier,
                          ),
                          const SizedBox(height: 30),
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
                                  OverlayLoader.appLoader.cancelLoaderTextNotifier,
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
                                  OverlayLoader.appLoader.cancelLoaderTextNotifier,
                                ),
                              ]),
                          const SizedBox(height: 60),
                          Row( mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                onPressed: () => {_hideCancelOverlay()}, //TODO: Cancel the appointment
                                child: Padding(padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                                  child: Text('YES, Cancel',
                                    style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),
                                  ),
                                ),
                              ),

                            ],),
                          Row( mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                onPressed: () => {_hideCancelOverlay()}, // I don't think I need to do anything here.
                                child: Padding(padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                                  child: Text('NO, Do not cancel',
                                    style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),
                                  ),
                                ),
                              ),

                            ],),

                          const SizedBox(height: 20),
                        ]),
                  ),
                ),
              ),
            ],),
        ),
      ),
    );
  }
}

class AppointmentDetailsOverlayView extends StatelessWidget {
  const AppointmentDetailsOverlayView({
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: OverlayLoader.appLoader.appointmentDetailsLoaderShowingNotifier,
      builder: (context, value, child) {
        if (value) {
          return appointmentDetailsOverlay(context);
        } else {
          return Container();
        }
      },
    );
  }

  Container appointmentDetailsOverlay(context) {
    debugPrint('appointmentDetailsOverlay being returned');
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
                                onPressed: () => _hideAppointmentDetailsOverlay(),
                              ),
                            ],
                          ),
                          Text('Day of Week',
                              style: GoogleFonts.dongle( textStyle:Theme.of(context)
                                  .textTheme.headline1,)
                                  .copyWith(color: Theme.of(context).scaffoldBackgroundColor, fontSize: 48)
                          ),
                          ValueListenableBuilder<String>(
                            builder: (context, value, child) {
                              return Text(value.split('|')[1], style: GoogleFonts.roboto(
                                textStyle:Theme.of(context).textTheme.bodyText2,
                              ).copyWith(color: Theme.of(context).scaffoldBackgroundColor,
                                  fontSize: 18),);
                            },
                            valueListenable:
                            OverlayLoader.appLoader.appointmentDetailsLoaderTextNotifier,
                          ),
                          const SizedBox(height: 30),
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
                                  OverlayLoader.appLoader.appointmentDetailsLoaderTextNotifier,
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
                                  OverlayLoader.appLoader.appointmentDetailsLoaderTextNotifier,
                                ),
                              ]),
                          const SizedBox(height: 60),
                          Padding(padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                              child:
                                Row( mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                          elevation: MaterialStateProperty.all<double>(0),
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                              const Color(0xff41434D)),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  side: const BorderSide(
                                                      width: 2.5,
                                                      color: Color(0xffF9F9F9))))),
                                      onPressed: () => {_hideAppointmentDetailsOverlay(),
                                        _presentCancelOverlay(OverlayLoader.appLoader.appointmentDetailsLoaderTextNotifier.value)},
                                      child: Text('Cancel Appointment',
                                        style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button).copyWith(color: const Color(0xffF9F9F9), fontSize: 18),),
                                    ),

                                  ],),
                          ),
                          const SizedBox(height: 20),
                        ]),
                  ),
                ),
              ),
            ],),
        ),
      ),
    );
  }
}

class OverlayLoader {
  static final OverlayLoader appLoader = OverlayLoader(); //singleton
  ValueNotifier<bool> joinLoaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> joinLoaderTextNotifier = ValueNotifier('message');
  ValueNotifier<bool> endLoaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> endLoaderTextNotifier = ValueNotifier('message');
  ValueNotifier<bool> cancelLoaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> cancelLoaderTextNotifier = ValueNotifier('message');
  ValueNotifier<bool> appointmentDetailsLoaderShowingNotifier = ValueNotifier(false);
  ValueNotifier<String> appointmentDetailsLoaderTextNotifier = ValueNotifier('message');

  void showJoinLoader() {
  joinLoaderShowingNotifier.value = true;
  }

  void hideJoinLoader() {
  joinLoaderShowingNotifier.value = false;
  }

  void setJoinOverlayText({String errorMessage = 'default'}) {
  joinLoaderTextNotifier.value = errorMessage;
  }

  void showEndLoader() {
    endLoaderShowingNotifier.value = true;
  }

  void hideEndLoader() {
    endLoaderShowingNotifier.value = false;
  }

  void setEndOverlayText({String errorMessage = 'default'}) {
    endLoaderTextNotifier.value = errorMessage;
  }

  void showCancelLoader() {
    cancelLoaderShowingNotifier.value = true;
  }

  void hideCancelLoader() {
    cancelLoaderShowingNotifier.value = false;
  }

  void setCancelOverlayText({String errorMessage = 'default'}) {
    cancelLoaderTextNotifier.value = errorMessage;
  }

  void showAppointmentDetailsLoader() {
    debugPrint('showAppointmentDetailsLoader');
    appointmentDetailsLoaderShowingNotifier.value = true;
    debugPrint(appointmentDetailsLoaderShowingNotifier.value.toString());
  }

  void hideAppointmentDetailsLoader() {
    debugPrint('hideAppointmentDetailsLoader');
    appointmentDetailsLoaderShowingNotifier.value = false;
  }

  void setAppointmentDetailsOverlayText({String errorMessage = 'default'}) {
    debugPrint('setAppointmentDetailsOverlayText');
    appointmentDetailsLoaderTextNotifier.value = errorMessage;
    debugPrint(appointmentDetailsLoaderTextNotifier.value);
  }
}

void _presentJoinOverlay(message) async {
  OverlayLoader.appLoader.showJoinLoader();
  OverlayLoader.appLoader.setJoinOverlayText(errorMessage: message);
  // await Future.delayed(Duration(seconds: 5)); // Hide it after 5 seconds for testing
  // Loader.appLoader.hideLoader();
}

void _hideJoinOverlay() async {
  OverlayLoader.appLoader.hideJoinLoader();
}

void _presentEndOverlay(message) async {
  OverlayLoader.appLoader.showEndLoader();
  OverlayLoader.appLoader.setEndOverlayText(errorMessage: message);
  // await Future.delayed(Duration(seconds: 5)); // Hide it after 5 seconds for testing
  // Loader.appLoader.hideLoader();
}

void _hideEndOverlay() async {
  OverlayLoader.appLoader.hideEndLoader();
}

void _presentCancelOverlay(message) async {
  OverlayLoader.appLoader.showCancelLoader();
  OverlayLoader.appLoader.setCancelOverlayText(errorMessage: message);
  // await Future.delayed(Duration(seconds: 5)); // Hide it after 5 seconds for testing
  // Loader.appLoader.hideLoader();
}

void _hideCancelOverlay() async {
  OverlayLoader.appLoader.hideCancelLoader();
}

void _presentAppointmentDetailsOverlay(message) async {
  debugPrint('_presentAppointmentDetailsOverlay');
  OverlayLoader.appLoader.showAppointmentDetailsLoader();
  OverlayLoader.appLoader.setAppointmentDetailsOverlayText(errorMessage: message);
  // await Future.delayed(Duration(seconds: 5)); // Hide it after 5 seconds for testing
  // Loader.appLoader.hideLoader();
}

void _hideAppointmentDetailsOverlay() async {
  OverlayLoader.appLoader.hideAppointmentDetailsLoader();
}


void _goToCall(context) => Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (_) => CallPage()),
);

void launchURL(url) async {
  if (!await launch(url)) throw 'Could not launch $url';
}