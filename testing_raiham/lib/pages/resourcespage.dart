import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import './home.dart';

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
        RichText(
          text: TextSpan(
            text: 'Hello ',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: 'bold', style: Theme.of(context).textTheme.bodyText2),
              TextSpan(text: ' world!'),
            ],
          ),
        )],)
    ),
  );

  void goHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => HomePage()),
  );
}
