import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freakyfreshkutz/repository/user_db.dart';

class UsersBloc {
  UsersBloc() {
    // ! ***** Constructor: initiate stream *****
    usersdb.initStream().listen((data) => _inFirestore.add(data));
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
    String id = await usersdb.createData(formData);
    this.id = id;
    _inId.add(id);
  }

  Future<DocumentReference> readData(String email) async {
    // ! ***** Read data from DB *****
    return await usersdb.readData(email);
  }

  void updateData(email, field, data) async {
    // ! ***** Update data from DB *****
    await usersdb.updateData(email, field, data);
  }

  void deleteData(DocumentSnapshot doc) async {
    // ! ***** Delete data from DB *****
    await usersdb.deleteData(doc);
    id = null;
    _inId.add(id);
  }
}
