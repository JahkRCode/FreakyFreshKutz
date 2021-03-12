import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/users_bloc.dart';
import 'package:freakyfreshkutz/screens/userHomeScreen.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var bloc = UsersBloc();

  final _formKey = new GlobalKey<FormState>();
  final formData = {
    vConstants.FORM_FIRST_NAME: '',
    vConstants.FORM_LAST_NAME: '',
    vConstants.FORM_PHONE_NUMBER: '',
    vConstants.FORM_EMAIL: '',
    vConstants.FORM_PASSWORD: '',
    vConstants.FORM_RETYPED_PASSWORD: '',
    vConstants.FORM_LAST_LOGIN: DateTime.now(),
  };

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (formData[vConstants.FORM_PASSWORD] ==
          formData[vConstants.FORM_RETYPED_PASSWORD]) {
        return true;
      } else {
        showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(vConstants.AD_PASSWORD_MISMATCH),
              content: Text(vConstants.AD_PASSWORD_MISMATCH_CONTENT),
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
          },
          context: context,
        );
        return false;
      }
    } else {
      return false;
    }
  }

  void _showDialog(error) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(vConstants.AD_LOGIN_ERROR),
            content: Text(error.toString()),
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

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        FirebaseUser user =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: formData[vConstants.FORM_EMAIL],
          password: formData[vConstants.FORM_PASSWORD],
        );
        bloc.createData(formData);
        final db = Firestore.instance;

        final DocumentReference userData =
            db.collection(vConstants.DB_USERS).document(user.email);
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) =>
                UserHomeScreen(currentUser: userData)));
      } catch (error) {
        _showDialog(error);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ! ***** FIRST NAME *****
    final firstName = TextFormField(
      autofocus: false,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      keyboardType: TextInputType.text,
      validator: (value) => value.isEmpty ? vConstants.FV_FIRST_NAME : null,
      onSaved: (value) => formData[vConstants.FORM_FIRST_NAME] = value,
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
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      keyboardType: TextInputType.text,
      validator: (value) => value.isEmpty ? vConstants.FV_LAST_NAME : null,
      onSaved: (value) => formData[vConstants.FORM_LAST_NAME] = value,
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
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      validator: (value) => value.isEmpty ? vConstants.FV_PHONE_NUMBER : null,
      onSaved: (value) => formData[vConstants.FORM_PHONE_NUMBER] = value,
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
    // ! ***** EMAIL ADDRESS *****
    final email = TextFormField(
      autofocus: false,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => value.isEmpty ? vConstants.FV_EMAIL : null,
      onSaved: (value) => formData[vConstants.FORM_EMAIL] = value,
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
        labelText: vConstants.FL_EMAIL,
        hintText: vConstants.FH_EMAIL,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );
    // ! ***** PASSWORD *****
    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      validator: (value) => value.isEmpty ? vConstants.FV_PASSWORD : null,
      onSaved: (value) => formData[vConstants.FORM_PASSWORD] = value,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Constants.THEME_ONE,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        labelStyle: TextStyle(color: Constants.THEME_ONE),
        labelText: vConstants.FL_PASSWORD,
        hintText: vConstants.FH_PASSWORD,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );
    // ! ***** RETYPED PASSWORD *****
    final retypedPassword = TextFormField(
      autofocus: false,
      obscureText: true,
      style: TextStyle(
          color: Constants.THEME_ONE, decorationColor: Constants.THEME_ONE),
      cursorColor: Constants.THEME_ONE,
      validator: (value) =>
          value.isEmpty ? vConstants.FV_RETYPED_PASSWORD : null,
      onSaved: (value) => formData[vConstants.FORM_RETYPED_PASSWORD] = value,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_ONE, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Constants.THEME_ONE,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        labelStyle: TextStyle(color: Constants.THEME_ONE),
        labelText: vConstants.FL_RETYPED_PASSWORD,
        hintText: vConstants.FH_RETYPED_PASSWORD,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );

    // ! ***** REGISTER BUTTON *****
    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Constants.THEME_SIX.shade100,
        color: Constants.THEME_FIVE,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: validateAndSubmit,
          color: Constants.THEME_SIX,
          child: Text(vConstants.BL_BECOME_CLIENT,
              style: TextStyle(color: Constants.THEME_TWO)),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Constants.THEME_BASE,
      appBar: AppBar(
        backgroundColor: Constants.THEME_BASE,
        title: Text(
          vConstants.BL_BECOME_CLIENT,
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
                  email,
                  SizedBox(
                    height: 8.0,
                  ),
                  password,
                  SizedBox(
                    height: 12.0,
                  ),
                  retypedPassword,
                  SizedBox(
                    height: 12.0,
                  ),
                  registerButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
