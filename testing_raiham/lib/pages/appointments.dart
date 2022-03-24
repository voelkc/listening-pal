import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './onboarding.dart';
import './updatedappts.dart';
import './home.dart';
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
  DateTime todayDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  final HomePage home = HomePage();
  bool showWidget = false;
  bool timeClicked = false;
  bool cancelClicked = false;
  String selectedTime = "";

  Map<DateTime, List<Event>> selectedEvents = {
    DateTime.utc(2022, 3, 3): [Event('3:30-4 PM', "Call with Jane")],
    DateTime.utc(2022, 3, 10): [Event('4-4:30 PM', "Call with Lilly")],
    DateTime.utc(2022, 3, 21): [Event('1:30-2 PM', "Call with Toby")],
    DateTime.utc(2022, 3, 25): [Event('9-9:30 PM', "Call with Jane")],
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,

        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: <Widget>[
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: [
          IconButton(
            onPressed: () => goToHomePage(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xff41434D),
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
          TextButton(
            onPressed: () => goToHomePage(context),
            child: Text(
              'Back',
              style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.bodyText1)
                  .copyWith(decoration: TextDecoration.none),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.07),
          TextButton(
            onPressed: () => home.goToResources(context),
            child: Text(
              'Resources',
              textAlign: TextAlign.right,
              style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.bodyText1)
                  .copyWith(decoration: TextDecoration.none),
            ),
          ),
          TextButton(
            onPressed: () => launchURL('https://listeningpal.com/'),
            child: Text(
              'Account',
              style: GoogleFonts.roboto(
                      textStyle: Theme.of(context).textTheme.bodyText1)
                  .copyWith(decoration: TextDecoration.none),
            ),
          ),
        ],
        //   )
        // ],
      ),
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
                          'You have 1 credit  available',
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
                    onPressed: () => launchURL('https://listeningpal.com/'),
                    child: Text(
                      'Purchase Credits',
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              fontSize: 14.0, color: Color(0xff41434D))),
                    ),
                  ),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 15, 0, 0),
                      child: Text('Select Date',
                          style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontSize: 24.0, color: Color(0xff41434D)),
                          ))),
                ]),
            Expanded(
              child: SizedBox(
                height: 300.0,
                width: 300.0,
                child: TableCalendar(
                  firstDay: DateTime(2022),
                  lastDay: DateTime(2023),
                  focusedDay: DateTime.utc(
                      _focusedDay.year, _focusedDay.month, _focusedDay.day),
                  calendarFormat: _calendarFormat,
                  calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Color(0xff95D4D8), shape: BoxShape.circle)),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    showWidget = true;
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          _buildPopupDialog(context),
                    );
                  },
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
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
            selectedEvents[DateTime.utc(_selectedDay.year, _selectedDay.month,
                        _selectedDay.day)] !=
                    null
                ? ListView(
                    key: selectedEvents[DateTime.utc(_selectedDay.year,
                                    _selectedDay.month, _selectedDay.day)]!
                                .length
                                .toString() !=
                            null
                        ? Key(selectedEvents[DateTime.utc(_selectedDay.year,
                                _selectedDay.month, _selectedDay.day)]!
                            .length
                            .toString())
                        : Key("0"),
                    padding: EdgeInsets.all(8),
                    shrinkWrap: true,
                    children: [
                      ..._getEventsfromDay(DateTime.utc(_selectedDay.year,
                              _selectedDay.month, _selectedDay.day))
                          .map(
                        (Event event) => GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildEditCallPopup(context),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15.0)),
                              child: ListTile(
                                title: Text(
                                    event.title + ' at ' + event.sessionTime),
                              ),
                            )),
                      )
                    ],
                  )
                : Text('No events',
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(color: Colors.white))),
          ],
        ),
      )));

  Widget buildEditCallPopup(
    BuildContext context,
  ) {
    return StatefulBuilder(
      builder: (context, setState) => AlertDialog(
          backgroundColor: Color(0xff41434D),
          title: cancelClicked
              ? Row(children: [
                  Text(
                    'Cancellation Confirmed',
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
                                Text('Your appointment has been cancelled.',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    )),
                                Text(
                                    '1 credit has been refunded to your account.',
                                    style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: 16.0, color: Colors.white),
                                    )),
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
                                              .sessionTime +
                                          ' on ' +
                                          DateFormat('MMMM dd, yyyy')
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(60, 20, 0, 0),
                                      child: ElevatedButton(
                                        child: Text('Cancel Appointment',
                                            style: GoogleFonts.roboto(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18.0))),
                                        style: ButtonStyle(
                                            elevation: MaterialStateProperty
                                                .all<double>(0),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xff95D4D8)),
                                            shape: MaterialStateProperty.all<
                                                    RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(22.0),
                                            ))),
                                        onPressed: (() => {
                                              setState(
                                                () => {
                                                  selectedEvents[_selectedDay
                                                      as DateTime] = [],
                                                  cancelClicked =
                                                      !cancelClicked,
                                                },
                                              )
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(100, 20, 0, 0),
                                  child: ElevatedButton(
                                    child: Text('Go Back',
                                        style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0))),
                                    style: ButtonStyle(
                                        elevation:
                                            MaterialStateProperty.all<double>(
                                                0),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color(0xff41434D)),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          side: BorderSide(color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(22.0),
                                        ))),
                                    onPressed: (() =>
                                        {Navigator.of(context).pop()}),
                                  ),
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
    var times = ['3-3:30pm', '3:30-4pm', '4-4:30pm'];
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
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.25, 0, 0, 40),
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
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.25, 0, 0, 40),
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
                                              fontSize: 12.0,
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
                                      DateFormat("MMMM dd, yyyy").format(
                                          DateTime.utc(
                                              _selectedDay.year,
                                              _selectedDay.month,
                                              _selectedDay.day)),
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
                                        textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 11.0))),
                                elevation: MaterialStateProperty.all<double>(0),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xff95D4D8)),
                                maximumSize: MaterialStateProperty.all<Size>(
                                    Size(
                                        MediaQuery.of(context).size.width * 0.2,
                                        40)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ))),
                            onPressed: (() => setState(() {
                                  timeClicked = !timeClicked;
                                  selectedTime = times[0];
                                })),
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
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 11.0))),
                              elevation: MaterialStateProperty.all<double>(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xff95D4D8)),
                              maximumSize: MaterialStateProperty.all<Size>(Size(
                                  MediaQuery.of(context).size.width * 0.2, 40)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: (() => setState(() {
                                timeClicked = !timeClicked;
                                selectedTime = times[0];
                              }))),
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
                                    textStyle: TextStyle(
                                        color: Colors.black, fontSize: 11.0))),
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff808080)),
                            maximumSize: MaterialStateProperty.all<Size>(Size(
                                MediaQuery.of(context).size.width * 0.2, 40)),
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
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.085, 20, 0, 0),
                      child: Visibility(
                          visible: timeClicked == true,
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
                                  goToUpdatedAppt(context)
                                }),
                            // ),
                          )),
                    )
                  ],
                )
              ])),
    );
  }
}

void goToHomePage(context) => Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
void goToUpdatedAppt(context) => Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              UpdatedApptPage(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero),
    );
