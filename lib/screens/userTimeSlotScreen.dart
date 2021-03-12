import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:freakyfreshkutz/blocs/calendar_bloc.dart';
import 'package:freakyfreshkutz/blocs/users_bloc.dart';
import 'package:freakyfreshkutz/screens/userHomeScreen.dart';
import 'package:square_in_app_payments/in_app_payments.dart';
import 'package:square_in_app_payments/models.dart' as MODEL;
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class UserTimeSlot extends StatefulWidget {
  final DocumentSnapshot selectedService;
  final DateTime selectedDate;
  final List<Event> bookedApts;
  final DocumentReference currentUser;

  UserTimeSlot(
      {Key key,
      this.selectedService,
      this.selectedDate,
      this.bookedApts,
      this.currentUser})
      : super(key: key);

  @override
  _UserTimeSlotState createState() => _UserTimeSlotState();
}

class _UserTimeSlotState extends State<UserTimeSlot> {
// ! ***** Initialize Global Variables *****
  String selectedFormattedDate;
  String selectedTimeSlot;
  String bookedApointment;
  String booker;
  bool transactionComplete;
  final timeSlots = vConstants.TIMESLOTS;
  var bloc = CalendarBloc();
  var userbloc = UsersBloc();

  Future<List<int>> avail;

  @override
  void initState() {
    super.initState();
    this.transactionComplete = false;
    selectedFormattedDate =
        '${widget.selectedDate.month}-${widget.selectedDate.day}-${widget.selectedDate.year}';

    avail = this.bloc.getAvailableTimeSlots(this.selectedFormattedDate,
        widget.selectedService[vConstants.TIME_SLOT]);
  }

  @override
  void dispose() {
    avail = null;
    selectedFormattedDate = null;
    this.bloc = null;
    super.dispose();
  }

// ! ***** Build Widget Method *****
  @override
  Widget build(BuildContext context) {
    final int duration = widget.selectedService.data[vConstants.TIME_SLOT] * 15;

    return Scaffold(
      backgroundColor: Constants.THEME_ONE,
      appBar: AppBar(
        title: Text(
          vConstants.SL_TIMESLOTS_AVAILABLE,
          style: TextStyle(
            fontSize: 25,
            color: Constants.THEME_ONE,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Constants.THEME_BASE,
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          Container(
            child: Center(
              child: Card(
                color: Constants.THEME_BASE,
                margin: EdgeInsets.all(5.0),
                elevation: 30.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                  child: Text(
                    '${vConstants.CL_BOOKING_INFO}${vConstants.CL_SERVICE} ${widget.selectedService.documentID}\n${vConstants.CL_DATE_SELECTED} ${this.selectedFormattedDate}\n${vConstants.CL_DURATION} $duration ${vConstants.CL_MIN}${vConstants.CL_PRICE} \$${widget.selectedService.data[vConstants.PRICE]}',
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
  FutureBuilder<List<int>> displayTimeSlot(CalendarBloc bloc, DateTime dt) {
    return FutureBuilder<List<int>>(
      future: this.avail,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
          return getAvailableTimes(context, snapshot, bloc);
        } else {
          return SizedBox();
        }
      },
    );
  }

// ! ***** ListView widget for each service item *****
  ListView getAvailableTimes(
      BuildContext context, AsyncSnapshot snapshot, calbloc) {
    widget.currentUser.get().then((DocumentSnapshot ds) {
      booker =
          '${widget.selectedService.documentID} -- ${ds[vConstants.FIRST_NAME]} ${ds['lastName']} -- ${ds[vConstants.PHONE_NUMBER]} -- ${widget.currentUser.documentID}';
    });
    List<int> values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0)),
              child: Material(
                elevation: 14.0,
                color: Constants.THEME_FOUR,
                borderRadius: BorderRadius.circular(24.0),
                shadowColor: Constants.THEME_BASE,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        fit: FlexFit.tight,
                        child: FlatButton(
                          onPressed: () {
                            _payment(values[index].toString());
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
                                            this.timeSlots[
                                                values[index].toString()],
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
            ),
            Divider(
              height: 5.0,
            )
          ],
        );
      },
    );
  }

  Future _payment(String timeSlot) async {
    this.bookedApointment =
        '${this.selectedFormattedDate} ${this.timeSlots[timeSlot]} ${widget.selectedService.documentID}';
    this.selectedTimeSlot = timeSlot;
    await InAppPayments.setSquareApplicationId(Constants.SQ_APPLICATION_ID);
    await InAppPayments.startCardEntryFlow(
        onCardNonceRequestSuccess: _cardNonceRequestSuccess,
        onCardEntryCancel: _cancelCardEntryFlow);
  }

  void _cardNonceRequestSuccess(MODEL.CardDetails result) async {
    // ! ***** Amount is calculated at: X * 0.01 *****
    try {
      // ! ***** Nahdya's Payment Algorithm *****
      var cost = widget.selectedService.data[vConstants.PRICE];
      //var x = cost;
      var n = cost * vConstants.CENT_CONVERSION;
      //var c = Constants.SQ_DEV_CUT;
      //var p = c * x;
      //var sqP = (p * vConstants.CENT_CONVERSION).round();

      String chargeServerHost = Constants.SQ_HOST_URL;
      String chargeUrl = "$chargeServerHost";
      var body = jsonEncode({
        vConstants.SQ_SOURCE_ID: '${result.nonce}',
        vConstants.SQ_CARD_NONCE: '${result.nonce}',
        vConstants.SQ_AUTOCOMPLETE: true,
        vConstants.SQ_LOCATION_ID: Constants.SQ_LOCATION_ID,
        vConstants.SQ_IDEMPOTENCY_KEY: DateTime.now().millisecond.toString(),
        vConstants.SQ_AMOUNT_MONEY: {
          vConstants.SQ_AMOUNT: n,
          vConstants.SQ_CURRENCY: Constants.SQ_CURRENCY
        },
        //vConstants.SQ_APP_FEE_MONEY: {vConstants.SQ_AMOUNT: sqP, vConstants.SQ_CURRENCY: Constants.SQ_CURRENCY}
      });
      http.Response response;
      try {
        response = await http.post(chargeUrl,
            body: body, headers: Constants.SQ_HEADER);
      } on Exception catch (ex) {
        throw Exception(ex.toString());
      }
      var responseBody = json.decode(response.body);
      if (response.statusCode == 200) {
        InAppPayments.completeCardEntry(
            onCardEntryComplete: _cardEntryComplete);
      } else {
        throw Exception(responseBody.toString());
      }
    } catch (ex) {
      _cardEntryComplete();
      InAppPayments.showCardNonceProcessingError(ex.toString());
    }
  }

  void _cancelCardEntryFlow() {
    // Handle the cancel callback
  }

  void _cardEntryComplete() {
    setState(() {
      this.transactionComplete = true;
    });
    userbloc.updateData(widget.currentUser.documentID, vConstants.APPOINTMENTS,
        bookedApointment);
    bloc.updateData(this.selectedTimeSlot, booker, selectedFormattedDate,
        widget.selectedService[vConstants.TIME_SLOT]);
    Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) =>
            UserHomeScreen(currentUser: widget.currentUser)));
  }
}

class ChargeException implements Exception {
  String errorMessage;
  ChargeException(this.errorMessage);
}
// ! ***** END OF CODE *****
