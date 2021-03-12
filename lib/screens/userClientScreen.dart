import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/users_bloc.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class UserClient extends StatefulWidget {
  final DocumentReference currentUser;
  UserClient({Key key, this.currentUser}) : super(key: key);

  @override
  _UserClientState createState() => _UserClientState();
}

class _UserClientState extends State<UserClient> {
  // ! ***** Initialize Global Variables *****
  final db = Firestore.instance;
  var bloc = UsersBloc();
  final _formKey = GlobalKey<FormState>();
  var formData = {
    vConstants.FORM_FIRST_NAME: '',
    vConstants.FORM_FIRST_NAME: '',
    vConstants.FORM_PHONE_NUMBER: '',
  };
  // ! ***** UserClientScreen DB Columns *****
  var _firstName = TextEditingController();
  var _lastName = TextEditingController();
  var _phoneNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _phoneNumber.dispose();
    this.formData.clear();
    super.dispose();
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(vConstants.AD_UPDATE_SUCCESSFUL),
            content: Text(vConstants.AD_UPDATE_CONTENT),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0)),
            backgroundColor: Constants.THEME_ONE,
            actions: <Widget>[
              FlatButton(
                color: Constants.THEME_FIVE,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0)),
                child: Text(
                  vConstants.BL_OK,
                  style: TextStyle(color: Constants.THEME_TWO, fontSize: 22),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

// ! ***** Build Widget Method *****
  @override
  Widget build(BuildContext context) {
    this.widget.currentUser.get().then((DocumentSnapshot ds) {
      this.formData[vConstants.FORM_FIRST_NAME] = ds[vConstants.FIRST_NAME];
      this.formData[vConstants.FORM_LAST_NAME] = ds[vConstants.LAST_NAME];
      this.formData[vConstants.FORM_PHONE_NUMBER] = ds[vConstants.PHONE_NUMBER];
    });
    _firstName.text = this.formData[vConstants.FORM_FIRST_NAME];
    _lastName.text = this.formData[vConstants.FORM_LAST_NAME];
    _phoneNumber.text = this.formData[vConstants.FORM_PHONE_NUMBER];
    // ! ***** FIRST NAME *****
    final firstName = TextFormField(
      autofocus: false,
      controller: _firstName,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      keyboardType: TextInputType.text,
      validator: (value) => value.isEmpty ? vConstants.FV_FIRST_NAME : null,
      onSaved: (value) => this.formData[vConstants.FORM_FIRST_NAME] = value,
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
        labelText: vConstants.FL_FIRST_NAME,
        hintText: vConstants.FH_FIRST_NAME,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );
    // ! ***** LAST NAME *****
    final lastName = TextFormField(
      autofocus: false,
      controller: _lastName,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      keyboardType: TextInputType.text,
      validator: (value) => value.isEmpty ? vConstants.FV_LAST_NAME : null,
      onSaved: (value) => this.formData[vConstants.FORM_LAST_NAME] = value,
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
        labelText: vConstants.FL_LAST_NAME,
        hintText: vConstants.FH_LAST_NAME,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );
    // ! ***** PHONE NUMBER *****
    final phoneNumber = TextFormField(
      autofocus: false,
      controller: _phoneNumber,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      validator: (value) => value.isEmpty ? vConstants.FV_PHONE_NUMBER : null,
      onSaved: (value) => this.formData[vConstants.FORM_PHONE_NUMBER] = value,
      keyboardType: TextInputType.phone,
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
        labelText: vConstants.FL_PHONE_NUMBER,
        hintText: vConstants.FH_PHONE_NUMBER,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );
    final updateButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Constants.THEME_SIX.shade100,
        color: Constants.THEME_FIVE,
        elevation: 5.0,
        child: MaterialButton(
            child: Text(vConstants.BL_UPDATE,
                style: TextStyle(
                    color: Constants.THEME_TWO,
                    fontWeight: FontWeight.bold,
                    fontSize: 22)),
            minWidth: 200.0,
            height: 42.0,
            onPressed: () {
              bloc.updateData(widget.currentUser.documentID,
                  vConstants.FIRST_NAME, _firstName.text);
              bloc.updateData(widget.currentUser.documentID,
                  vConstants.LAST_NAME, _lastName.text);
              bloc.updateData(widget.currentUser.documentID,
                  vConstants.PHONE_NUMBER, _phoneNumber.text);
              _showDialog();
              this.formData.clear();
            }),
      ),
    );
    return Scaffold(
      backgroundColor: Constants.THEME_BASE,
      appBar: AppBar(
        backgroundColor: Constants.THEME_BASE,
        title: Text(
          vConstants.BL_EDIT_INFO,
          style: TextStyle(
            fontSize: 25,
            color: Constants.THEME_ONE,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 48.0,
                  ),
                  firstName,
                  SizedBox(
                    height: 8.0,
                  ),
                  lastName,
                  SizedBox(
                    height: 8.0,
                  ),
                  phoneNumber,
                  SizedBox(
                    height: 8.0,
                  ),
                  updateButton
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ! ***** END OF CODE *****
}
