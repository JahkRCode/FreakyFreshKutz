import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class ServicesDB {
  Firestore servicesdb = Firestore.instance;

  Stream<QuerySnapshot> initStream() {
    return servicesdb.collection(vConstants.DB_SERVICES).snapshots();
  }

  Future<String> createData(Map<String, dynamic> formData) async {
    var description = formData[vConstants.FORM_DESCRIPTION];
    var price = formData[vConstants.FORM_PRICE];
    int timeSlot = formData[vConstants.FORM_TIME_SLOT];
    await servicesdb
        .collection(vConstants.DB_SERVICES)
        .document(formData[vConstants.FORM_NAME])
        .setData({
      vConstants.DESCRIPTION: description,
      vConstants.PRICE: price,
      vConstants.TIME_SLOT: timeSlot,
    });
    DocumentReference ref = servicesdb
        .collection(vConstants.DB_SERVICES)
        .document(formData[vConstants.FORM_NAME]);
    return ref.documentID.toString();
  }

  readData() {
    final readD = servicesdb.collection(vConstants.DB_SERVICES).snapshots();
    return readD;
  }

  Future<void> deleteData(DocumentSnapshot doc) async {
    await servicesdb
        .collection(vConstants.DB_SERVICES)
        .document(doc.documentID)
        .delete();
  }
}

ServicesDB servicesdb = ServicesDB();
