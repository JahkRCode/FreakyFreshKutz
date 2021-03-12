import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/services_bloc.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class Services extends StatefulWidget {
  final DocumentReference currentUser;
  Services({Key key, this.currentUser}) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  // ! ***** Initialize Global Variables *****
  final _formKey = GlobalKey<FormState>();

  // ! ***** Services DB Columns *****
  final formData = {
    vConstants.FORM_NAME: '',
    vConstants.FORM_DESCRIPTION: '',
    vConstants.FORM_PRICE: 0,
    vConstants.FORM_TIME_SLOT: 0
  };
  final _name = TextEditingController();
  final _description = TextEditingController();
  final _price = TextEditingController();
  final _timeSlot = TextEditingController();
  String description = 'Update form to receive required data for DB';
  int price = 22;
  int timeSlot = 0;

// ! ***** Build Widget Method *****
  @override
  Widget build(BuildContext context) {
    final serviceName = TextFormField(
      autofocus: false,
      controller: _name,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      keyboardType: TextInputType.text,
      validator: (value) => value.isEmpty ? vConstants.FV_NAME : null,
      onSaved: (value) => formData[vConstants.FORM_NAME] = value,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        labelStyle: TextStyle(color: Constants.THEME_ONE),
        labelText: vConstants.FL_NAME,
        hintText: vConstants.FH_NAME,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );
    final serviceDesc = TextFormField(
      autofocus: false,
      controller: _description,
      minLines: 1,
      maxLines: 4,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      keyboardType: TextInputType.text,
      validator: (value) => value.isEmpty ? vConstants.FV_DESCRIPTION : null,
      onSaved: (value) => formData[vConstants.FORM_DESCRIPTION] = value,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        labelStyle: TextStyle(color: Constants.THEME_ONE),
        labelText: vConstants.FL_DESCRIPTION,
        hintText: vConstants.FH_DESCRIPTION,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );
    final servicePrice = TextFormField(
      autofocus: false,
      controller: _price,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      keyboardType: TextInputType.number,
      validator: (value) => value.isEmpty ? vConstants.FV_PRICE : null,
      onSaved: (value) => formData[vConstants.FORM_PRICE] = int.tryParse(value),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        labelStyle: TextStyle(color: Constants.THEME_ONE),
        labelText: vConstants.FL_PRICE,
        hintText: vConstants.FH_PRICE,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );
    final serviceTimeSlot = TextFormField(
      autofocus: false,
      controller: _timeSlot,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      keyboardType: TextInputType.number,
      validator: (value) => value.isEmpty ? vConstants.FV_TIME_SLOT : null,
      onSaved: (value) =>
          formData[vConstants.FORM_TIME_SLOT] = int.tryParse(value),
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        labelStyle: TextStyle(color: Constants.THEME_ONE),
        labelText: vConstants.FL_TIME_SLOT,
        hintText: vConstants.FH_TIME_SLOT,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );

    final bloc = ServicesBloc();
    return Scaffold(
      backgroundColor: Constants.THEME_BASE,
      appBar: AppBar(
        title: Text(
          vConstants.SL_SERVICES,
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
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                serviceName,
                SizedBox(
                  height: 8.0,
                ),
                serviceDesc,
                SizedBox(
                  height: 8.0,
                ),
                servicePrice,
                SizedBox(
                  height: 8.0,
                ),
                serviceTimeSlot,
                SizedBox(
                  height: 8.0,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0)),
                onPressed: () => createData(bloc),
                child: Text(
                  vConstants.BL_CREATE_UPDATE,
                  style: TextStyle(color: Constants.THEME_ONE),
                ),
                color: Constants.THEME_FOUR,
              ),
            ],
          ),
          readIt(bloc)
        ],
      ),
    );
  }

// ! ***** Display List of Services on Screen Load *****
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
        if (snapshot.connectionState == ConnectionState.waiting) {
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
                  onPressed: () {},
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
                              '\$${doc.data[vConstants.PRICE]}',
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
              // ! ***** Card Buttons: Update & Delete *****
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    onPressed: () => {
                          this._name.text = doc.documentID,
                          this._description.text =
                              doc.data[vConstants.DESCRIPTION],
                          this._price.text =
                              doc.data[vConstants.PRICE].toString(),
                          this._timeSlot.text =
                              doc.data[vConstants.TIME_SLOT].toString(),
                        },
                    child: Text(
                      vConstants.BL_UPDATE,
                      style:
                          TextStyle(fontSize: 12, color: Constants.THEME_ONE),
                    ),
                    color: Constants.THEME_FOUR,
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0)),
                    onPressed: () => bloc.deleteData(doc),
                    child: Icon(
                      Icons.delete,
                      color: Constants.THEME_ONE,
                    ),
                    color: Constants.THEME_FOUR,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createData(bloc) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      bloc.createData(formData);
    }
  }
  // ! ***** END OF CODE *****
}
