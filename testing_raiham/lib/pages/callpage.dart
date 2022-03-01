import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import './home.dart';

import 'package:url_launcher/url_launcher.dart';

class CallPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
   backgroundColor: Theme.of(context).secondaryHeaderColor,
   body: Column (mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Padding(padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
    child: Column (mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
      children: [ Text('Jane',
        style: GoogleFonts.dongle( textStyle:Theme.of(context).textTheme.headline1,).copyWith(color: Theme.of(context).scaffoldBackgroundColor),
      ),Text('0:01',
        style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText2,).copyWith(color: Theme.of(context).scaffoldBackgroundColor),
      ),]
    ),
        ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
            child:  Row (mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(120, 0, 0, 80),
                child: Column (mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                children:[ Ink( //TODO: Make icons bigger once we figure out how to do that, if you make them bigger now, they will leave the BoxDecoration
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor, width: 4.0),
                        shape: BoxShape.circle,
                      ),
                        child: IconButton(onPressed: () {}, icon: Icon(
                          Icons.mic_off_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 28.0,
                          semanticLabel: 'toggle mute user microphone',
                        ),
                        ),
                  ),
                  Text('mute',
                    style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText2,).copyWith(color: Theme.of(context).primaryColor),)], ),
              ),
              Padding(padding: const EdgeInsets.fromLTRB(0, 0, 120, 80),
                child: Column (mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center,
                  children:[ Ink( //TODO: Make icons bigger once we figure out how to do that, if you make them bigger now, they will leave the BoxDecoration
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor, width: 4.0),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(onPressed: () {}, icon: Icon(
                      Icons.mic_off_outlined,
                      color: Theme.of(context).primaryColor,
                      size: 28.0,
                      semanticLabel: 'toggle speaker',
                    ),
                    ),

                  ),
                    Text('speaker',
                      style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.bodyText2,).copyWith(color: Theme.of(context).primaryColor),)], ),
              ),
              ],
              ),
          ),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child:  ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(149, 212, 216, 1)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(
                              color: Color(0xff95D4D8))))),
              onPressed: () => goHome(context),
              child: Padding(padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
  child: Text('Leave Call', style: GoogleFonts.roboto( textStyle:Theme.of(context).textTheme.button).copyWith(fontSize: 18),),
              ),
            ),
          ),
        ],
   ),
  );

  void goHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => HomePage()),
  );
}
