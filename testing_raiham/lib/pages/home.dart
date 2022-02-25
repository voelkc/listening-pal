import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import './onboarding.dart';
import './resourcespage.dart';
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            backgroundColor:  Theme.of(context).scaffoldBackgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () => goToResources(context),
                icon:  const Icon(
                Icons.folder,
                color:  Color(0xff41434D),
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),),

              Icon(
                Icons.settings,
                color: Color(0xff41434D),
                size: 30.0,
              ),
            ],
          )
        ),
        body: Center(
          child: Padding(padding:EdgeInsets.fromLTRB(10, 0, 10, 0), child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    'Hey, pal!',
                    //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    style: GoogleFonts.dongle( textStyle:Theme.of(context).textTheme.headline1),
                  ), Text(
                    'You have X credits available',
                    //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText2),
                  ),
                ]),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xffF9F9F9)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    width: 2.5,
                                    color: Color(0xff95D4D8))))),
                    onPressed: () => goToOnBoarding(context),
                    child: Text('Purchase Credits',
                        style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),),
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
                            side: BorderSide(
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
                    Padding(padding: EdgeInsets.fromLTRB(120, 0, 0, 0), child: const Icon(
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
                            side: BorderSide(
                                color: Color(0xff95D4D8))))),
                onPressed: () => goToOnBoarding(context),
                child: Text('Go Back', style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button),),
              ),
            ], // Chillen
          ),
          ),
        ),
      );

  void goToOnBoarding(context) => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => OnboardingPage()),
      );

  void goToResources(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => ResourcesPage()),
  );
}
