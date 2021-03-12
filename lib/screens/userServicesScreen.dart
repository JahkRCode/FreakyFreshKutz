import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/services_bloc.dart';
import 'package:freakyfreshkutz/screens/userBookAppointmentScreen.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class UserServices extends StatefulWidget {
  final DocumentReference currentUser;
  UserServices({Key key, this.currentUser}) : super(key: key);

  @override
  _UserServicesState createState() => _UserServicesState();
}

class _UserServicesState extends State<UserServices> {
// ! ***** Build Widget Method *****
  @override
  Widget build(BuildContext context) {
    final bloc = ServicesBloc();
    return Scaffold(
      backgroundColor: Constants.THEME_BASE,
      appBar: AppBar(
        title: Text(
          vConstants.SL_SELECT_SERVICE,
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
        children: <Widget>[readIt(bloc)],
      ),
    );
  }

// ! ***** Display List of UserServices on Screen Load *****
  StreamBuilder<QuerySnapshot> readIt(ServicesBloc bloc) {
    return StreamBuilder<QuerySnapshot>(
      stream: bloc.outFirestore,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error);
        }
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.active) {
          return Column(
              children: snapshot.data.documents
                  .map((doc) => buildItem(doc, bloc))
                  .toList());
        }
        if (snapshot.connectionState != ConnectionState.active) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

// ! ***** Card widget for each service item *****
  Card buildItem(DocumentSnapshot doc, bloc) {
    int duration = doc.data[vConstants.TIME_SLOT] * 15;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      child: Material(
        elevation: 14.0,
        color: Constants.CARD_THEME_BASE,
        borderRadius: BorderRadius.circular(24.0),
        shadowColor: Constants.THEME_BASE,
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: FlatButton(
                  onPressed: () => Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UserBookAppointment(
                                selectedService: doc,
                                currentUser: widget.currentUser,
                              ))),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                child: Text(
                                  doc.documentID,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Constants.THEME_ONE,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                child: Text(
                                  doc.data[vConstants.DESCRIPTION],
                                  style: TextStyle(
                                      fontSize: 14, color: Constants.THEME_ONE),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              vConstants.CL_PRICE,
                              style: TextStyle(
                                  fontSize: 12, color: Constants.THEME_TWO),
                            ),
                            Text(
                              '\$${doc.data['price']}',
                              style: TextStyle(
                                  fontSize: 14, color: Constants.THEME_ONE),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              vConstants.CL_DURATION,
                              style: TextStyle(
                                  fontSize: 12, color: Constants.THEME_TWO),
                            ),
                            Text(
                              '$duration ${vConstants.CL_MINUTES}',
                              style: TextStyle(
                                  fontSize: 14, color: Constants.THEME_ONE),
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
  // ! ***** END OF CODE *****
}
