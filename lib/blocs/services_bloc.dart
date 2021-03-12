import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freakyfreshkutz/repository/services_db.dart';

class ServicesBloc {
  ServicesBloc() {
    // ! ***** Constructor: initiate stream *****
    servicesdb.initStream().listen((data) => _inFirestore.add(data));
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

  void createData(Map<String, dynamic> formData) async {
    // ! ***** Create data from DB *****
    String id = await servicesdb.createData(formData);
    this.id = id;
    _inId.add(id);
  }

  readData() async {
    // ! ***** Read data from DB *****
    final data = await servicesdb.readData();
    _inFirestore.add(data);
  }

  void deleteData(DocumentSnapshot doc) async {
    // ! ***** Delete data from DB *****
    await servicesdb.deleteData(doc);
    id = null;
    _inId.add(id);
  }
}
