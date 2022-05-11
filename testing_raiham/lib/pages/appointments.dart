import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './onboarding.dart';
import 'dart:async';
import 'dart:convert';
import './updatedappts.dart';
import './home.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Event {
  const Event(this.sessionTime, this.title);
  final String sessionTime;
  final String title;
}

Object body = {"userID": 1};

class ApptPage extends StatefulWidget {
  @override
  _TableBasicsState createState() => _TableBasicsState();
}

// "05/1103:30PM"
availParser(String) {
  var commaIndx = [];
  var i = 0;
  for (int i = 0; String.length; i++) {
    if (String.indexOf(',') != -1) {
      commaIndx.add(String.indexOf(','));
    }
  }
  var x = "";
  while (!commaIndx.contains(i) && i < String.length) {
    x = String.substring(i, i + 5) +
        "/2022 " +
        String.substring(i + 5, i + 10) +
        " " +
        String.substring(i + 10, i + 12);
    i += 12;
  }
  DateFormat format = new DateFormat("MM/dd/yyy hh:mm a");
  return format.parse(x);
}

class Appt {
  final int aid;
  final int uid;
  final int lid;
  final DateTime stime;
  final DateTime etime;
  final String webRTC;
  final int creditsBefore;
  final int creditsAfter;
  final int canceled;
  final int comp;

  const Appt(
      {required this.aid,
      required this.uid,
      required this.lid,
      required this.stime,
      required this.etime,
      required this.webRTC,
      required this.creditsBefore,
      required this.creditsAfter,
      required this.canceled,
      required this.comp});
  factory Appt.fromJSON(Map<String, dynamic> json) {
    return Appt(
        aid: json['AppointmentID'],
        uid: json['UserID'],
        lid: json['ListenerID'],
        stime: DateTime.parse(json['StartTime']),
        etime: DateTime.parse(json['EndTime']),
        webRTC: json['WebRTCRoom'],
        creditsBefore: json['UserCreditsBefore'],
        creditsAfter: json['UserCreditsAfter'],
        canceled: json['Canceled'],
        comp: json['Completed']);
  }
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

  Map<DateTime, List<Appt>> selectedEvents = {};

  String selectedSession = '';
  @override
  void initState() {
    super.initState();
    userAppts = getUserAppts();
    final DateFormat formatter = DateFormat('YYYY-MM-dd');
    userAppts.then((userAppts) => {
          for (var day in userAppts)
            {selectedEvents[formatter.format(day.stime)]?.add(day)}
        });
  }

  Future<List<Appt>> getUserAppts() async {
    print('trying');
    final response = await http.post(
        Uri.parse(
            'https://54sz8yaq55.execute-api.us-west-2.amazonaws.com/getUserAppts'),
        body: jsonEncode(body),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Accept": "application/json"
        });
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final data = jsonResponse['response'][0][0];
      // print(data);
      List<Appt> userEvents = [];
      data.forEach((element) {
        element = element as Map<String, dynamic>;
        userEvents.add(Appt.fromJSON(element));
      });
      final DateFormat formatter = DateFormat('YYYY-MM-dd');

      userEvents.forEach((element) {
        setState(() {
          selectedEvents[formatter.format(element.stime)]?.add(element);
        });
      });

      return userEvents;
    } else {
      throw Exception('Failed to do anything');
    }
  }

  Future<Appt> createUserAppt(Object body) async {
    final response = await http.post(
        Uri.parse(
            'https://54sz8yaq55.execute-api.us-west-2.amazonaws.com/userSchedulesCall'),
        body: jsonEncode(body),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Accept": "application/json"
        });

    if (response.statusCode == 200) {
      setState(() {});
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to do anything');
    }
  }

  Future<Appt> cancelUserAppt(Object body) async {
    final response = await http.post(
        Uri.parse(
            'https://54sz8yaq55.execute-api.us-west-2.amazonaws.com/userSchedulesCall'),
        body: jsonEncode(body),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Accept": "application/json"
        });
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to do anything');
    }
  }

  List<Appt> _getEventsfromDay(DateTime selectedDay) {
    getUserAppts();
    return selectedEvents[selectedDay] ?? [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  late Future<List<Appt>> userAppts;

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
              const SizedBox(width: 60),
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
          )),
      body: Center(
          child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hey, pal!',
                          //style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          style: GoogleFonts.dongle(
                              textStyle: Theme.of(context).textTheme.headline1),
                        ),
                      ]),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'You have ',
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            ),
                            TextSpan(
                              text: '1',
                              style: GoogleFonts.roboto(
                                      textStyle:
                                          Theme.of(context).textTheme.bodyText2)
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: ' credit available',
                              style: GoogleFonts.roboto(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyText2),
                            )
                          ]),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all<double>(0),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xffF9F9F9)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          width: 2.5,
                                          color: Color(0xff95D4D8))))),
                          onPressed: () =>
                              launchURL('https://listeningpal.com/'),
                          child: Text(
                            'Get Credits',
                            style: GoogleFonts.roboto(
                                textStyle: Theme.of(context).textTheme.button),
                          ),
                        ),
                      ]),
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
            FutureBuilder<List<Appt>>(
                future: userAppts,
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<Appt>> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return (Expanded(
                      child: SizedBox(
                        height: 300.0,
                        width: 300.0,
                        child: TableCalendar(
                          firstDay: DateTime(2022),
                          lastDay: DateTime(2023),
                          focusedDay: DateTime.utc(_focusedDay.year,
                              _focusedDay.month, _focusedDay.day),
                          calendarFormat: _calendarFormat,
                          calendarStyle: CalendarStyle(
                              todayDecoration: BoxDecoration(
                                  color: Color(0xff95D4D8),
                                  shape: BoxShape.circle)),
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
                        ),
                      ),
                    ));
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return (Expanded(
                        child: SizedBox(
                          height: 300.0,
                          width: 300.0,
                          child: TableCalendar(
                              firstDay: DateTime(2022),
                              lastDay: DateTime(2023),
                              focusedDay: DateTime.utc(_focusedDay.year,
                                  _focusedDay.month, _focusedDay.day),
                              calendarFormat: _calendarFormat,
                              calendarStyle: CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                      color: Color(0xff95D4D8),
                                      shape: BoxShape.circle)),
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
                              eventLoader: _getEventsfromDay),
                        ),
                      ));
                    } else {
                      return Text('${snapshot.connectionState}');
                    }
                  }
                  return (Expanded(
                    child: SizedBox(
                      height: 300.0,
                      width: 300.0,
                      child: TableCalendar(
                        firstDay: DateTime(2022),
                        lastDay: DateTime(2023),
                        focusedDay: DateTime.utc(_focusedDay.year,
                            _focusedDay.month, _focusedDay.day),
                        calendarFormat: _calendarFormat,
                        calendarStyle: CalendarStyle(
                            todayDecoration: BoxDecoration(
                                color: Color(0xff95D4D8),
                                shape: BoxShape.circle)),
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
                      ),
                    ),
                  ));
                }),
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
                    // children:
                    // [
                    //   ..._getEventsfromDay(DateTime.utc(_selectedDay.year,
                    //           _selectedDay.month, _selectedDay.day))
                    //       .map(
                    //     (Appt event) => GestureDetector(
                    //         onTap: () {
                    //           showDialog(
                    //             context: context,
                    //             builder: (BuildContext context) =>
                    //                 buildEditCallPopup(context),
                    //           );
                    //         },
                    //         child: Card(
                    //           shape: RoundedRectangleBorder(
                    //               side: BorderSide(color: Colors.grey),
                    //               borderRadius: BorderRadius.circular(15.0)),
                    //           child: ListTile(
                    //             title: Text(
                    //                 '$event.lid' + ' at ' + '$event.stime'),
                    //           ),
                    //         )),
                    //   )
                    // ],
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
                                              .stime
                                              .toString() +
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
                                          .lid
                                          .toString(),
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
    List<String> times = [];
    selectedEvents[_selectedDay]?.forEach((element) {
      times.add(DateFormat.Hm(element.stime).toString());
    });
    String? selectedTime = "";
    List<Widget> temp = [];
    for (var i = 1; i < times.length; i++) {
      temp.add(
        ElevatedButton(
          child: Text(times[0],
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(color: Colors.black))),
          style: ButtonStyle(
              textStyle: MaterialStateProperty.all<TextStyle>(
                  GoogleFonts.roboto(
                      textStyle:
                          TextStyle(color: Colors.black, fontSize: 11.0))),
              elevation: MaterialStateProperty.all<double>(0),
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xff95D4D8)),
              maximumSize: MaterialStateProperty.all<Size>(
                  Size(MediaQuery.of(context).size.width * 0.2, 40)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          onPressed: (() => setState(() {
                timeClicked = !timeClicked;
                selectedTime = times[0];
              })),
        ),
      );
    }
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
                        : DropdownButton<String>(
                            hint: Text("Please select a time",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(color: Colors.white),
                                )),
                            value: selectedTime,
                            items: times.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedTime = newValue;
                              });
                            },
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
                                  // if (selectedEvents[_selectedDay] == null)
                                  //   {
                                  createUserAppt(
                                      {"userID": 1, "StartTime": selectedTime}),
                                  // },
                                  // else
                                  //   {
                                  //     selectedEvents[_selectedDay as DateTime] =
                                  //         [
                                  //       // Appt(selectedTime, 'Session with Sam')
                                  //     ]
                                  //   },
                                  getUserAppts(),
                                  Navigator.pop(context),
                                  selectedTime = "",
                                  timeClicked = false,
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
      // MaterialPageRoute(builder: (_) => UpdatedApptPage()),
    );
