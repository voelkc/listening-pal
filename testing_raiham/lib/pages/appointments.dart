import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './onboarding.dart';
import './home.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class ApptPage extends StatefulWidget {
  // @override
  // const ApptPage({Key? key}) : super(key: key);
  @override
  _TableBasicsState createState() => _TableBasicsState();
}

class _TableBasicsState extends State<ApptPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  var _chosenValue = null;
  bool showWidget = false;
  bool timeClicked = false;
  bool selectedTime = false;
  bool selectedTime2 = false;

  @override
  Widget build(BuildContext context) => Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const <Widget>[
              Icon(
                Icons.folder,
                color: Color(0xff41434D),
                size: 24.0,
                semanticLabel: 'Links to resources page',
              ),
              Icon(
                Icons.settings,
                color: Color(0xff41434D),
                size: 30.0,
                semanticLabel: 'Links to settings page',
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
                              textStyle: Theme.of(context).textTheme.headline1),
                        ),
                        Text(
                          'You have X credits available',
                          //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          style: GoogleFonts.roboto(
                              textStyle: Theme.of(context).textTheme.bodyText2),
                        ),
                      ]),
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all<double>(0),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffF9F9F9)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                      child: Text(
                        'Select Date',
                        //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                        style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.headline6),
                      )),
                ]),
            // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            //   Text(
            //     'Select Date',
            //     style: GoogleFonts.dongle(
            //         textStyle: Theme.of(context).textTheme.headline6),
            //   ),
            // ]),
            Expanded(
              child: SizedBox(
                height: 300.0,
                width: 300.0,
                child: TableCalendar(
                  firstDay: DateTime(2022),
                  lastDay: DateTime(2023),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      // Call `setState()` when updating the selected day
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        // _calendarFormat = CalendarFormat.twoWeeks;
                      });
                      showWidget = true;
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _buildPopupDialog(context),
                      );
                    }
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      // Call `setState()` when updating calendar format
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
            ),
          ],
        ),
      )));
  Widget _buildPopupDialog(
    BuildContext context,
  ) {
    var times = ['3:00-3:30pm', '3:30-4:00pm', '4:00-4:30pm'];
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
          backgroundColor: Color(0xff41434D),
          title: timeClicked
              ? Row(children: [
                  Text(
                    'Confirmation',
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding: EdgeInsets.fromLTRB(200, 0, 0, 50),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )),
                  ),
                ])
              : Row(children: [
                  Text(
                    'Select Time',
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        padding: EdgeInsets.fromLTRB(200, 0, 0, 50),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.white,
                        )),
                  ),
                ]),
          content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    timeClicked
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(
                                  children: [
                                    Text(
                                        'Use 1 credit to book the following appointment:',
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                  ),
                                  Text(
                                      DateFormat("MM-dd-yyyy")
                                          .format(_selectedDay as DateTime),
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ))
                                ]),
                                Row(children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                  ),
                                  Text(times[0],
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ))
                                ])
                              ])
                        : ElevatedButton(
                            child: Text(times[0]),
                            style: ButtonStyle(
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                    GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.black))),
                                elevation: MaterialStateProperty.all<double>(0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff95D4D8)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            onPressed: (() => setState(() {
                                  timeClicked = !timeClicked;
                                  selectedTime = !selectedTime;
                                })),
                          ),
                    // ),
                    SizedBox(
                      width: 5,
                    ),
                    Visibility(
                      visible: timeClicked == false,
                      child: ElevatedButton(
                        child: Text(times[1]),
                        style: ButtonStyle(
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                GoogleFonts.roboto(
                                    textStyle: TextStyle(color: Colors.black))),
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff95D4D8)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        onPressed: (() => setState(() {
                              timeClicked = !timeClicked;
                              selectedTime2 = !selectedTime2;
                            })),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Visibility(
                      visible: timeClicked == false,
                      child: ElevatedButton(
                        child: Text(times[2]),
                        style: ButtonStyle(
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                GoogleFonts.roboto(
                                    textStyle: TextStyle(color: Colors.black))),
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff808080)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        onPressed: (() => null),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Visibility(
                        visible: timeClicked == true,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(80, 50, 0, 0),
                          child: ElevatedButton(
                            child: Text('Confirm Appointment',
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: Colors.black, fontSize: 20.0))),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff95D4D8)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                            onPressed: (() => null),
                          ),
                        )),
                  ],
                )
              ])),
    );
  }
}

void goToOnBoarding(context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => OnboardingPage()),
    );
