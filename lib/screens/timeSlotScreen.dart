import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:freakyfreshkutz/blocs/calendar_bloc.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class TimeSlot extends StatefulWidget {
  final DateTime selectedDate;
  final List<Event> bookedApts;

  TimeSlot({Key key, this.selectedDate, this.bookedApts}) : super(key: key);

  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  // ! ***** Initialize Global Variables *****
  String selectedTimeSlot;
  String selectedService;
  final timeSlots = vConstants.REF_TIMESLOTS;
  final getTimeSlots = vConstants.TIMESLOTS;
  final availableTimeSlots = vConstants.AVAILABLE_TIMESLOTS;
  final db = Firestore.instance;

// ! ***4** Build Widget Method *****
  @override
  Widget build(BuildContext context) {
    final bloc = CalendarBloc();
    final String formattedDate =
        '${widget.selectedDate.month}-${widget.selectedDate.day}-${widget.selectedDate.year}';

// ! ***** Dropdown Menu for Hour, Minutes in 15 intervals, AM/PM *****
    final hourDropDownButton = DropdownButton<String>(
      elevation: 30,
      hint: Text(
        vConstants.FV_SELECT_TIME_SLOT,
        style: TextStyle(color: Constants.THEME_ONE),
      ),
      items: availableTimeSlots.map((String timeSlot) {
        return DropdownMenuItem<String>(
          value: timeSlot,
          child: Text(timeSlot,
              style: TextStyle(
                fontSize: 20,
                color: Constants.THEME_ONE,
                fontWeight: FontWeight.w900,
              )),
        );
      }).toList(),
      onChanged: (String timeSlot) {
        setState(() {
          this.selectedTimeSlot = timeSlot;
        });
      },
      value: this.selectedTimeSlot,
    );

    void _addTimeSlot(String timeSlot) {
      String timeValue = this.timeSlots[timeSlot];
      bloc.createData(formattedDate, timeValue);
      setState(() {
        this.selectedTimeSlot = null;
      });
    }

    final addSelectedTimeButton = RaisedButton(
      elevation: 14,
      color: Constants.THEME_FOUR,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Text(
        vConstants.BL_ADD_TIME,
        style: TextStyle(
            color: Constants.THEME_ONE,
            fontSize: 16,
            fontWeight: FontWeight.w900),
      ),
      onPressed: () {
        (this.selectedTimeSlot != null)
            ? _addTimeSlot(this.selectedTimeSlot)
            : print('**** FULL TIME SLOT: ${this.selectedTimeSlot}');
      },
    );

    return Scaffold(
      backgroundColor: Constants.CARD_THEME_BASE,
      appBar: AppBar(
        title: Text(
          vConstants.SL_TIMESLOTS_AVAILABLE,
          style: TextStyle(
            fontSize: 25,
            color: Constants.THEME_ONE,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Constants.CARD_THEME_BASE,
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Container(
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  hourDropDownButton,
                  addSelectedTimeButton,
                ],
              ),
            ),
          ),
          Container(
            child: Center(
              child: Card(
                color: Constants.CARD_THEME_BASE,
                margin: EdgeInsets.all(5.0),
                elevation: 30.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                  child: Text(
                    '${vConstants.CL_SELECTED_DATE} ${widget.selectedDate.month}/${widget.selectedDate.day}/${widget.selectedDate.year}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Constants.THEME_ONE,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ),
          displayTimeSlot(bloc, widget.selectedDate)
        ],
      ),
    );
  }

// ! ***** Display List of Services on Screen Load *****
  StreamBuilder<QuerySnapshot> displayTimeSlot(bloc, DateTime dt) {
    final String formattedDT = '${dt.month}-${dt.day}-${dt.year}';
    return StreamBuilder<QuerySnapshot>(
      stream: db
          .collection(vConstants.DB_CALENDAR)
          .document(formattedDT)
          .collection(vConstants.DB_TIMESLOTS)
          .orderBy(vConstants.ORDER)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          return Column(
              children: snapshot.data.documents.map((doc) {
            return (doc.data[vConstants.SERVICE] == vConstants.AVAILABLE)
                ? getAvailableTime(doc, bloc)
                : getUnavailableTime(doc, bloc);
          }).toList());
        } else {
          return SizedBox();
        }
      },
    );
  }

  showBooked(formattedDate, DocumentSnapshot doc, bloc) {
    this.selectedService = doc[vConstants.SERVICE];
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$formattedDate ${this.getTimeSlots[doc.documentID]}'),
            content: Text(this.selectedService),
            actions: <Widget>[
              FlatButton(
                child: Text(vConstants.BL_OK),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Card getUnavailableTime(doc, bloc) {
    String formattedDate =
        '${widget.selectedDate.month}-${widget.selectedDate.day}-${widget.selectedDate.year}';
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Material(
        elevation: 14.0,
        color: Constants.THEME_SEVEN,
        borderRadius: BorderRadius.circular(24.0),
        shadowColor: Constants.CARD_THEME_BASE,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: FlatButton(
                  onPressed: () {
                    this.showBooked(formattedDate, doc, bloc);
                  },
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    '${this.getTimeSlots[doc.documentID]}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Constants.THEME_ONE,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// ! ***** Card widget for each service item *****
  Card getAvailableTime(DocumentSnapshot doc, CalendarBloc calbloc) {
    String formattedDate =
        '${widget.selectedDate.month}-${widget.selectedDate.day}-${widget.selectedDate.year}';
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Material(
        elevation: 14.0,
        color: Constants.THEME_FOUR,
        borderRadius: BorderRadius.circular(24.0),
        shadowColor: Constants.CARD_THEME_BASE,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: FlatButton(
                  onPressed: () {},
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    this.getTimeSlots[doc.documentID],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Constants.THEME_ONE,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0)),
                onPressed: () => calbloc.deleteData(formattedDate, doc),
                child: Icon(
                  Icons.delete,
                  color: Constants.THEME_ONE,
                ),
                color: Constants.THEME_FOUR,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ! ***** END OF CODE *****
}
