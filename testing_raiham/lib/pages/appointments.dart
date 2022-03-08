import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './onboarding.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class Event {
  const Event(this.sessionTime, this.title);
  final String sessionTime;
  final String title;
}

class ApptPage extends StatefulWidget {
  @override
  _TableBasicsState createState() => _TableBasicsState();
}

class _TableBasicsState extends State<ApptPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();

  bool showWidget = false;
  bool timeClicked = false;
  bool cancelClicked = false;
  String selectedTime = "";

  Map<DateTime, List<Event>> selectedEvents = {
    DateTime.utc(2022, 3, 3): [Event('3:30-4:00 PM', "Call with Jane")],
    DateTime.utc(2022, 3, 8): [Event('4:00-4:30 PM', "Call with Lilly")],
    DateTime.utc(2022, 3, 16): [Event('4:00-4:30 PM', "Call with Sam")],
    DateTime.utc(2022, 3, 21): [Event('1:30-2:00 PM', "Call with Toby")],
    DateTime.utc(2022, 3, 25): [Event('9:00-9:30 PM', "Call with Jane")],
  };

  String selectedSession = '';
  @override
  void initState() {
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                          style: GoogleFonts.dongle(
                              textStyle: Theme.of(context).textTheme.headline1),
                        ),
                        Text(
                          'You have X credits available',
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
                        style: GoogleFonts.roboto(
                            textStyle: Theme.of(context).textTheme.headline6),
                      )),
                ]),
            Expanded(
              child: SizedBox(
                height: 300.0,
                width: 300.0,
                child: TableCalendar(
                  firstDay: DateTime(2022),
                  lastDay: DateTime(2023),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Color(0xff95D4D8), shape: BoxShape.circle)),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    // if (!isSameDay(_selectedDay, selectedDay)) {
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
                  },
                  // },
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
                  eventLoader: _getEventsfromDay,
                ),
              ),
            ),
            ..._getEventsfromDay(_selectedDay as DateTime).map(
              (Event event) => GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildEditCallPopup(context),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15.0)),
                    child: ListTile(
                      title: Text(event.title + ' at ' + event.sessionTime),
                    ),
                  )),
            )
          ],
        ),
      )));
  Widget _buildEditCallPopup(
    BuildContext context,
  ) {
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
          backgroundColor: Color(0xff41434D),
          title: cancelClicked
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
                    'Edit Call',
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
                    cancelClicked
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(
                                  children: [
                                    Text(
                                        DateFormat("EEEE")
                                            .format(_selectedDay as DateTime),
                                        style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white),
                                        )),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      DateFormat("MMMM dd, yyyy")
                                          .format(_selectedDay as DateTime),
                                      // if i have to do this one more im gonna jump
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ))
                                ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('waa',
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ))
                                ])
                              ])
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Row(children: [
                                  Icon(
                                    Icons.alarm,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      selectedEvents[_selectedDay]!
                                          .elementAt(0)
                                          .sessionTime,
                                      // if i have to do this one more im gonna jump
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ))
                                ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.verified_user_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      selectedEvents[_selectedDay]!
                                          .elementAt(0)
                                          .title,
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ))
                                ]),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      child: Text('Cancel Appointment',
                                          style: GoogleFonts.roboto(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0))),
                                      style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all<double>(
                                                  0),
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xff95D4D8)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(22.0),
                                          ))),
                                      onPressed: (() => {
                                            selectedEvents[
                                                _selectedDay as DateTime] = [],
                                            Navigator.pop(context),
                                            cancelClicked = !cancelClicked,
                                          }),
                                    ),
                                  ],
                                )
                              ])
                  ],
                )
              ])),
    );
  }

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
                                SizedBox(
                                  height: 15,
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                      DateFormat("MMMM dd, yyyy")
                                          .format(_selectedDay as DateTime),
                                      // if i have to do this one more im gonna jump
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ))
                                ]),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(times[0],
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ))
                                ])
                              ])
                        : ElevatedButton(
                            child: Text(times[0],
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(color: Colors.black))),
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
                                  // if((_selectedDay as DateTime).isBefore(DateTime.now())){
                                  timeClicked = !timeClicked;
                                  selectedTime = times[0];
                                  // } else {
                                  //   null;
                                  // }
                                })),
                          ),
                    // ),
                    SizedBox(
                      width: 5,
                    ),
                    Visibility(
                      visible: timeClicked == false,
                      child: ElevatedButton(
                        child: Text(times[1],
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(color: Colors.black))),
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
                              selectedTime = times[1];
                            })),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Visibility(
                      visible: timeClicked == false,
                      child: ElevatedButton(
                        child: Text(times[2],
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(color: Colors.black))),
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
                                        color: Colors.black, fontSize: 18.0))),
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all<double>(0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff95D4D8)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.0),
                                ))),
                            onPressed: (() => {
                                  if (selectedEvents[_selectedDay] != null)
                                    {
                                      selectedEvents[_selectedDay as DateTime]
                                          ?.add(
                                        Event(selectedTime, 'Session with Sam'),
                                      )
                                    }
                                  else
                                    {
                                      selectedEvents[_selectedDay as DateTime] =
                                          [
                                        Event(selectedTime, 'Session with Sam')
                                      ]
                                    },
                                  Navigator.pop(context),
                                  selectedTime = "",
                                  timeClicked = false,
                                }),
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
