import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freakyfreshkutz/repository/calendar_db.dart';

class CalendarBloc {
  CalendarBloc() {
    // ! ***** Constructor: initiate stream *****
    calendardb.initStream().listen((data) => _inFirestore.add(data));
  }
  String id;
  final _idController = StreamController<String>.broadcast();
  Stream<String> get outId => _idController.stream;
  Sink<String> get _inId => _idController.sink;

  final _firestoreController = StreamController<QuerySnapshot>.broadcast();
  Stream<QuerySnapshot> get outFirestore => _firestoreController.stream;
  Sink<QuerySnapshot> get _inFirestore => _firestoreController.sink;

  void dispose() {
    _idController.close();
    _firestoreController.close();
  }

  void createData(String date, String time) async {
    // ! ***** Create data from DB *****
    String id = await calendardb.createData(date, time);
    this.id = id;
    _inId.add(id);
  }

  void readData(date, time) async {
    // ! ***** Read data from DB *****
    await calendardb.readData(date, time);
  }

  void updateData(
      String time, String service, String date, int timeSlot) async {
    // ! ***** Update data from DB *****
    await calendardb.updateData(time, service, date, timeSlot);
  }

  void deleteData(String date, DocumentSnapshot doc) async {
    // ! ***** Delete data from DB *****
    await calendardb.deleteData(date, doc);
    id = null;
    _inId.add(id);
  }

  Future<QuerySnapshot> showAllTimes(date) async {
    return (await calendardb.showAllTimes(date));
  }

  getAvailableTimeSlots(String date, int timeSlot) {
    // ! ***** Read data from DB *****
    return calendardb.getAvailableTimeSlots(date, timeSlot);
  }
}
