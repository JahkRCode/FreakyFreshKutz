import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class CalendarDB {
  final calendardb = Firestore.instance;
  String selectedService;
  List<int> availableTimeSlots = [];
  List<int> serviceAvailableTimeSlots = [];
  List<int> serviceTimeSlots = [];

  Stream<QuerySnapshot> initStream() {
    return calendardb.collection(vConstants.DB_CALENDAR).snapshots();
  }

  Future<String> createData(String date, String time) async {
    int timeReference = int.parse(time);
    await calendardb
        .collection(vConstants.DB_CALENDAR)
        .document(date)
        .setData({vConstants.HAS_TIMES: true});

    await calendardb
        .collection(vConstants.DB_CALENDAR)
        .document(date)
        .collection(vConstants.DB_TIMESLOTS)
        .document(time)
        .setData({
      vConstants.SERVICE: vConstants.AVAILABLE,
      vConstants.ORDER: timeReference
    });
    DocumentReference ref = calendardb
        .collection(vConstants.DB_CALENDAR)
        .document(date)
        .collection(vConstants.DB_TIMESLOTS)
        .document(time);
    return ref.documentID.toString();
  }

  Future<void> readData(date, time) async {
    DocumentReference ref = calendardb
        .collection(vConstants.DB_CALENDAR)
        .document(date)
        .collection(vConstants.DB_TIMESLOTS)
        .document(time);
    ref.get().then((DocumentSnapshot ds) {
      this.selectedService = ds[vConstants.SERVICE];
    });
    return this.selectedService;
  }

  Future<void> updateData(
      String time, String service, String date, int timeSlot) async {
    timeSlot -= 1;
    int convTime = int.parse(time);
    DocumentReference ref =
        calendardb.collection(vConstants.DB_CALENDAR).document(date);
    for (var start = 0; start <= timeSlot; start++) {
      await ref
          .collection(vConstants.DB_TIMESLOTS)
          .document(convTime.toString())
          .updateData({
        vConstants.SERVICE: service,
      });

      convTime += 1;
    }
  }

  Future<void> deleteData(String date, DocumentSnapshot doc) async {
    await calendardb
        .collection(vConstants.DB_CALENDAR)
        .document(date)
        .collection(vConstants.DB_TIMESLOTS)
        .document(doc.documentID)
        .delete();
  }

  Future<QuerySnapshot> showAllTimes(date) async {
    QuerySnapshot qs = await calendardb
        .collection(vConstants.DB_CALENDAR)
        .document(date)
        .collection(vConstants.DB_TIMESLOTS)
        .orderBy(vConstants.ORDER)
        .getDocuments();
    return qs;
  }

  Future<List<int>> getAvailableTimeSlots(String date, int timeSlots) async {
    var sats = [];
    var ats = [];

    await calendardb
        .collection(vConstants.DB_CALENDAR)
        .document(date)
        .collection(vConstants.DB_TIMESLOTS)
        .where(vConstants.SERVICE, isEqualTo: vConstants.AVAILABLE)
        .orderBy(vConstants.ORDER)
        .getDocuments()
        .then((data) => data.documents.forEach(
            (doc) => this.availableTimeSlots.add(doc[vConstants.ORDER])));

    ats = List<int>.from(this.availableTimeSlots);

    ats.forEach((data) {
      var prevValue;
      if (this.serviceAvailableTimeSlots.length == 0 && data > 0) {
        prevValue = data - 1;
      } else if (this.serviceAvailableTimeSlots.length == 0 && data == 0) {
        prevValue = 0;
      } else {
        prevValue = this.serviceAvailableTimeSlots[
            this.serviceAvailableTimeSlots.length - 1];
      }
      var currValue = data;
      if (prevValue + 1 == currValue || currValue == prevValue) {
        this.serviceAvailableTimeSlots.add(currValue);
      } else {
        this.serviceAvailableTimeSlots.clear();
        this.serviceAvailableTimeSlots.add(currValue);
      }
      if (this.serviceAvailableTimeSlots.length == timeSlots) {
        this.serviceTimeSlots.add(this.serviceAvailableTimeSlots[0]);
        this
            .serviceAvailableTimeSlots
            .remove(this.serviceAvailableTimeSlots[0]);
      }
    });
    sats = List<int>.from(this.serviceTimeSlots);

    this.serviceAvailableTimeSlots.clear();
    this.availableTimeSlots.clear();
    this.serviceTimeSlots.clear();

    return sats;
  }
}

CalendarDB calendardb = CalendarDB();
