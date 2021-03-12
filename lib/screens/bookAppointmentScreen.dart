import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:freakyfreshkutz/screens/timeSlotScreen.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class BookAppointment extends StatefulWidget {
  BookAppointment({Key key}) : super(key: key);
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  final db = Firestore.instance;
  DateTime _currentDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime _currentDate2 =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  String _currentMonth = '';
  Future<void> getCalendarEventList() async {
    Firestore.instance.collection(vConstants.DB_CALENDAR).snapshots().listen(
        (data) => data.documents.forEach((doc) => doc.data.values != null
            ? setState(() {
                _markedDateMap.add(
                    new DateTime(
                        int.parse(doc.documentID.split('-')[2]),
                        int.parse(doc.documentID.split('-')[0]),
                        int.parse(doc.documentID.split('-')[1])),
                    new Event(
                        date: new DateTime(
                            int.parse(doc.documentID.split('-')[2]),
                            int.parse(doc.documentID.split('-')[0]),
                            int.parse(doc.documentID.split('-')[1])),
                        title: ('${doc.data.keys}'),
                        icon: _eventIcon));
              })
            : print('$doc.data')));
  }

  CalendarCarousel _calendarCarouselNoHeader;
  @override
  void initState() {
    super.initState();
    getCalendarEventList();
  }

  @override
  void dispose() {
    _markedDateMap.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ! ***** Calendar with custom prev & next button *****
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      daysHaveCircularBorder: true,
      todayBorderColor: Constants.THEME_FOUR,
      onDayPressed: (DateTime date, List<Event> events) {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => TimeSlot(
                  selectedDate: date,
                  bookedApts: events,
                )));
      },
      daysTextStyle: TextStyle(color: Constants.THEME_FOUR, fontSize: 22),
      weekdayTextStyle: TextStyle(color: Constants.THEME_FOUR, fontSize: 22),
      weekendTextStyle: TextStyle(color: Constants.THEME_FOUR, fontSize: 22),
      todayTextStyle: TextStyle(color: Constants.THEME_FOUR, fontSize: 22),
      selectedDayTextStyle: TextStyle(color: Constants.THEME_SIX, fontSize: 22),
      thisMonthDayBorderColor: Constants.THEME_BASE,
      weekFormat: false,
      markedDatesMap: _markedDateMap,
      height: 777.0,
      selectedDateTime: _currentDate2,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: false,
      showHeader: false,
      markedDateIconBuilder: (event) {
        return event.icon;
      },
      todayButtonColor: Constants.THEME_SIX,
      minSelectedDate: _currentDate,
      maxSelectedDate: _currentDate.add(Duration(days: 365)),
      onCalendarChanged: (DateTime date) {
        this.setState(() => _currentMonth = DateFormat.yMMM().format(date));
      },
    );

    // ! ***** Scaffold - Display Screen Content *****'
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.THEME_BASE,
          title: Center(
            child: Text(
              vConstants.SL_SCHEDULE_BOOKING,
              style: TextStyle(color: Constants.THEME_ONE),
            ),
          ),
        ),
        backgroundColor: Constants.THEME_ONE,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: 30.0,
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                      _currentMonth,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    )),
                    FlatButton(
                      child: Text(vConstants.BL_PREV),
                      onPressed: () {
                        setState(() {
                          _currentDate2 =
                              _currentDate2.subtract(Duration(days: 30));
                          _currentMonth =
                              DateFormat.yMMM().format(_currentDate2);
                        });
                      },
                    ),
                    FlatButton(
                      child: Text(vConstants.BL_NEXT),
                      onPressed: () {
                        setState(() {
                          _currentDate2 = _currentDate2.add(Duration(days: 30));
                          _currentMonth =
                              DateFormat.yMMM().format(_currentDate2);
                        });
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: _calendarCarouselNoHeader,
              ),
            ],
          ),
        ));
  }
}

EventList<Event> _markedDateMap = EventList<Event>(
  events: {},
);

Widget _eventIcon = Container(
  decoration: BoxDecoration(
      color: Constants.THEME_BASE,
      borderRadius: BorderRadius.all(Radius.circular(1000)),
      border: Border.all(color: Constants.THEME_TWO, width: 2.0)),
  child: Icon(
    Icons.person,
    color: Constants.THEME_EIGHT,
  ),
);
