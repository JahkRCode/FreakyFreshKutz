import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class UsersDB {
  Firestore usersdb = Firestore.instance;
  Stream<QuerySnapshot> initStream() {
    return usersdb.collection(vConstants.DB_USERS).snapshots();
  }

  Future<String> createData(Map<String, dynamic> formData) async {
    var firstName = formData[vConstants.FORM_FIRST_NAME];
    var lastName = formData[vConstants.FORM_LAST_NAME];
    var phoneNumber = formData[vConstants.FORM_PHONE_NUMBER];
    var adsClicked = 0;
    var isAdmin = false;
    var appointments = [];
    var lastLogin = formData[vConstants.FORM_LAST_LOGIN];
    String convEmail = formData[vConstants.FORM_EMAIL];
    await usersdb
        .collection(vConstants.DB_USERS)
        .document(convEmail.toLowerCase())
        .setData({
      vConstants.FIRST_NAME: firstName,
      vConstants.LAST_NAME: lastName,
      vConstants.PHONE_NUMBER: phoneNumber,
      vConstants.ADS_CLICKED: adsClicked,
      vConstants.ISADMIN: isAdmin,
      vConstants.APPOINTMENTS: appointments,
      vConstants.LAST_LOGIN: lastLogin,
    });
    DocumentReference ref = usersdb
        .collection(vConstants.DB_USERS)
        .document(formData[vConstants.FORM_EMAIL]);
    return ref.documentID.toString();
  }

  Future<DocumentReference> readData(String email) async {
    DocumentReference readD =
        usersdb.collection(vConstants.DB_USERS).document(email);
    return readD;
  }

  Future<void> updateData(email, field, data) async {
    final updateArray = usersdb.collection(vConstants.DB_USERS).document(email);
    switch (field) {
      case vConstants.ADS_CLICKED:
        {
          int getAdsClicked;
          await updateArray.get().then((DocumentSnapshot ds) {
            getAdsClicked = ds[vConstants.ADS_CLICKED];
          });
          getAdsClicked = getAdsClicked + data;
          await updateArray.updateData({field: getAdsClicked});
        }
        break;
      case vConstants.APPOINTMENTS:
        {
          await updateArray.updateData({
            field: FieldValue.arrayUnion([data])
          });
        }
        break;
      case vConstants.FIRST_NAME:
        {
          await updateArray.updateData({field: data});
        }
        break;
      case vConstants.ISADMIN:
        {
          await updateArray.updateData({field: data});
        }
        break;
      case vConstants.LAST_LOGIN:
        {
          await updateArray.updateData({field: data});
        }
        break;
      case vConstants.LAST_NAME:
        {
          await updateArray.updateData({field: data});
        }
        break;
      case vConstants.PHONE_NUMBER:
        {
          await updateArray.updateData({field: data});
        }
        break;
      default:
        {
          await updateArray.updateData({field: data});
        }
    }
  }

  Future<void> deleteData(DocumentSnapshot doc) async {
    await usersdb
        .collection(vConstants.DB_USERS)
        .document(doc.documentID)
        .delete();
  }
}

UsersDB usersdb = UsersDB();
