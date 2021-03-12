import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/users_bloc.dart';
import 'package:freakyfreshkutz/screens/homeScreen.dart';
import 'package:freakyfreshkutz/screens/login/registerScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freakyfreshkutz/screens/userHomeScreen.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var bloc = UsersBloc();

  final formKey = new GlobalKey<FormState>();
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
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        FirebaseUser user =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: formData[vConstants.FORM_EMAIL],
          password: formData[vConstants.FORM_PASSWORD],
        );
        final bloc = UsersBloc();
        bloc.updateData(user.email, vConstants.LAST_LOGIN,
            formData[vConstants.FORM_LAST_LOGIN]);

        final DocumentReference userData = await bloc.readData(user.email);
        userData.get().then((DocumentSnapshot ds) async {
          Navigator.of(context).pop();
          (ds[vConstants.ISADMIN] == true)
              ? //! ***** USER IS ADMIN ******
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) =>
                      HomeScreen(currentUser: userData)))
              : //! ***** USER NOT ADMIN ******
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (BuildContext context) =>
                      UserHomeScreen(currentUser: userData)));
        });
      } catch (error) {
        showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(vConstants.AD_LOGIN_ERROR),
              content: Text(error.message),
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
          },
          context: context,
        );
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
    final logo = Hero(
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 200.0,
        child: Image.asset(
          Constants.ASSETS_LOGO_ONE,
          height: 350,
          fit: BoxFit.cover,
        ),
      ),
      tag: vConstants.MT_HERO,
    );

    final email = TextFormField(
      autofocus: false,
      style: TextStyle(
          color: Constants.THEME_TWO, decorationColor: Constants.THEME_TWO),
      cursorColor: Constants.THEME_TWO,
      keyboardType: TextInputType.emailAddress,
      validator: (value) => value.isEmpty ? vConstants.FV_EMAIL : null,
      onSaved: (value) => formData[vConstants.FORM_EMAIL] = value,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_TWO, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_TWO, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        labelStyle: TextStyle(color: Constants.THEME_TWO),
        labelText: vConstants.FL_EMAIL,
        hintText: vConstants.FH_EMAIL,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      obscureText: true,
      style: TextStyle(
          color: Constants.THEME_TWO, decorationColor: Constants.THEME_TWO),
      cursorColor: Constants.THEME_TWO,
      validator: (value) => value.isEmpty ? vConstants.FV_PASSWORD : null,
      onSaved: (value) => formData[vConstants.FORM_PASSWORD] = value,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Constants.THEME_TWO, width: 1),
          borderRadius: BorderRadius.circular(32.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Constants.THEME_TWO,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(32.0),
        ),
        labelStyle: TextStyle(color: Constants.THEME_TWO),
        labelText: vConstants.FL_PASSWORD,
        hintText: vConstants.FH_PASSWORD,
        contentPadding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Constants.THEME_THREE.shade100,
        color: Constants.THEME_TWO,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: validateAndSubmit,
          color: Constants.THEME_TWO,
          child: Text(vConstants.BL_CLIENT_LOGIN,
              style: TextStyle(color: Constants.THEME_FIVE)),
        ),
      ),
    );

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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => RegisterScreen()));
          },
          color: Constants.THEME_SIX,
          child: Text(vConstants.BL_BECOME_CLIENT,
              style: TextStyle(color: Constants.THEME_TWO)),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Constants.THEME_BASE,
      body: Center(
        child: ListView(
          shrinkWrap: false,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  email,
                  SizedBox(
                    height: 8.0,
                  ),
                  password,
                  SizedBox(
                    height: 12.0,
                  ),
                  loginButton,
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
