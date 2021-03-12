import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/users_bloc.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class ClientsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = UsersBloc();
    return Scaffold(
      backgroundColor: Constants.THEME_BASE,
      appBar: AppBar(
        title: Text(
          vConstants.SL_CLIENT_LIST,
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

// ! ***** Display List of Users on Screen Load *****
  StreamBuilder<QuerySnapshot> readIt(UsersBloc bloc) {
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

// ! ***** Card widget for each user item *****
  Card buildItem(DocumentSnapshot doc, bloc) {
    Timestamp lastLogin = doc.data[vConstants.LAST_LOGIN];
    var llDate = lastLogin.toDate();
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
                  onPressed: () {},
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                child: Text(
                                  '${doc.data[vConstants.FIRST_NAME]} ${doc.data[vConstants.LAST_NAME]}',
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
                                  '${doc.documentID}',
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
                              vConstants.CL_PHONE_NUMBER,
                              style: TextStyle(
                                  fontSize: 12, color: Constants.THEME_TWO),
                            ),
                            Text(
                              '${doc.data[vConstants.PHONE_NUMBER]}',
                              style: TextStyle(
                                  fontSize: 14, color: Constants.THEME_ONE),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              vConstants.CL_BOOKED_APPOINTMENTS,
                              style: TextStyle(
                                  fontSize: 12, color: Constants.THEME_TWO),
                            ),
                            Flexible(
                              child: Container(
                                child: Text(
                                  doc.data[vConstants.APPOINTMENTS] != null
                                      ? '${doc.data[vConstants.APPOINTMENTS].toString()}'
                                      : '${doc.data[vConstants.APPOINTMENTS][0].toString()}',
                                  softWrap: true,
                                  style: TextStyle(
                                      fontSize: 14, color: Constants.THEME_ONE),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              vConstants.CL_ADS_CLICKED,
                              style: TextStyle(
                                  fontSize: 12, color: Constants.THEME_TWO),
                            ),
                            Text(
                              '${doc.data['adsClicked']}',
                              style: TextStyle(
                                  fontSize: 14, color: Constants.THEME_ONE),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              vConstants.CL_LAST_LOGIN,
                              style: TextStyle(
                                  fontSize: 12, color: Constants.THEME_TWO),
                            ),
                            Text(
                              '${llDate.toLocal()}',
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
}
