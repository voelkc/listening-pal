import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/retry.dart';
import './onboarding.dart';
import 'dart:async';
import 'dart:convert';
import './updatedappts.dart';
import './home.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';

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
  List<Appt> userEvents = [];

  late Future<List<dynamic>> fut_userTimes;
  List<String> userTimes = [];

  String selectedSession = '';
  @override
  void initState() {
    initializeDateFormatting('en_US');
    super.initState();

    fut_userTimes = getAvailTimes();
    fut_userTimes.then((value) => value.forEach((element) {
          userTimes.add(element.toString());
        }));

    DateFormat dateFormat = DateFormat.yMd('en_US');
    userAppts = getUserAppts();
    userAppts.then((appts) {
      appts.forEach((element) {
        element = element as Map<String, dynamic>;
        userEvents.add(Appt.fromJSON(element));
      });
    });
    userEvents.forEach(
        (appt) => {selectedEvents[dateFormat.format(appt.stime)]?.add(appt)});
  }

  Future<List<dynamic>> getUserAppts() async {
    print('im gonna cry');
    final response = await http.post(
        Uri.parse(
            'https://54sz8yaq55.execute-api.us-west-2.amazonaws.com/getUserAppts'),
        body: jsonEncode(body),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Accept": "application/json"
        });
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode("[" + response.body + "]");

      List data = jsonResponse[0]['response'][0][0] as List<dynamic>;
      // List<Appt> userEvents = [];
      // data.forEach((element) {
      //   element = element as Map<String, Appt>;
      //   userEvents.add(Appt.fromJSON(element));
      // });

      return data;
    } else {
      throw Exception('Failed to do anything');
    }
  }

  Future<List<dynamic>> getAvailTimes() async {
    print('trying');
    final response = await http.post(
        Uri.parse(
            'https://54sz8yaq55.execute-api.us-west-2.amazonaws.com/getAllAvailability'),
        body: jsonEncode(body),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Accept": "application/json"
        });
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode("[" + response.body + "]");

      List data =
          jsonResponse.toList()[0]['totalAvailability'] as List<dynamic>;
      // List<dynamic> availTimes = [];
      // var data2 = data as List<DateTime>;
      // data2.forEach((element) {
      //   // DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
      //   // element = DateTime.parse(formatter.format(element));
      //   availTimes.add(element);
      // });

      return data;
    } else {
      throw Exception('Failed to do anything');
    }
  }

  Future createUserAppt(Object body) async {
    final response = await http.post(
        Uri.parse(
            'https://54sz8yaq55.execute-api.us-west-2.amazonaws.com/userSchedulesCall'),
        body: jsonEncode(body),
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Accept": "application/json"
        });

    if (response.statusCode == 200) {
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
    return selectedEvents[selectedDay] ?? [];
  }

  @override
  void dispose() {
    super.dispose();
  }

  late Future<List<dynamic>> userAppts;
  Future<List<dynamic>> fetchResults() async {
    List<dynamic> results = [];
    final result1 = await fut_userTimes;
    final result2 = await userAppts;
    results.add(result1);
    results.add(result2);
    return results;
  }

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
            FutureBuilder<List<dynamic>>(
                future: fetchResults(),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot,
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
                                if (snapshot.data?[0] != null) {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        _buildPopupDialog(
                                            context, snapshot.data?[0]),
                                  );
                                }
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

  Widget _buildPopupDialog(BuildContext context, List<dynamic> data) {
    List<String> availTimes = [];
    print("tears streaming down my face");
    String selectedDateTime = "";
    List<String> dateTimes = [];
    data.forEach((element) {
      DateTime parseDate =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element);
      var inputDate = DateTime.parse(parseDate.toString());
      var outputFormat = DateFormat('MM/dd/yyyy');
      var outputDate = outputFormat.format(inputDate);
      var outputTime = DateFormat.Hm('en').format(inputDate);
      var selectedDate = outputFormat.format(_selectedDay);
      DateTime parseDate_0 =
          new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(element);
      var inputDate_0 = DateTime.parse(parseDate_0.toString());
      var outputFormat_0 = DateFormat("yyyy-MM-dd HH:mm:ss");
      var outputTime_0 = outputFormat_0.format(inputDate_0);
      if (outputDate == selectedDate) {
        availTimes.add(outputTime);
        dateTimes.add(outputTime_0);
      }
    });

    String? selectedTime = dateTimes[0];

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
                                  Text('$selectedTime',
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      ))
                                ])
                              ])
                        : availTimes.length > 1
                            ? Column(children: [
                                DropdownButton<String>(
                                  hint: Text("Please select a time",
                                      style: GoogleFonts.roboto(
                                        textStyle:
                                            TextStyle(color: Colors.white),
                                      )),
                                  value: availTimes[0],
                                  items: availTimes.map((String value) {
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
                                IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                    onPressed: () => {
                                          setState(() {
                                            timeClicked = true;
                                          })
                                        })
                              ])
                            : (Text("No available appointment times.",
                                style: GoogleFonts.roboto(
                                  textStyle: TextStyle(color: Colors.white),
                                )))
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
                                  // make selectedTime into availability-like string
                                  selectedDateTime = DateFormat("hh:mma")
                                      .format(DateFormat("HH:mm")
                                          .parse(selectedTime!)),

                                  if (_selectedDay.month < 10)
                                    {
                                      selectedDateTime =
                                          _selectedDay.month.toString() +
                                              "/0" +
                                              _selectedDay.day.toString() +
                                              "/" +
                                              _selectedDay.year.toString() +
                                              selectedDateTime,
                                    }
                                  else
                                    {
                                      selectedDateTime =
                                          _selectedDay.month.toString() +
                                              "/" +
                                              _selectedDay.day.toString() +
                                              "/" +
                                              _selectedDay.year.toString() +
                                              selectedDateTime,
                                    },
                                  print(selectedDateTime),
                                  createUserAppt({
                                    "userID": 1,
                                    "StartTime": selectedDateTime
                                  }),
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
