import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class ContactMe extends StatelessWidget {
  Future launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fbButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(45.0),
        shadowColor: Constants.THEME_ONE,
        color: Constants.THEME_BASE,
        elevation: 50.0,
        child: MaterialButton(
          minWidth: 40.0,
          height: 40.0,
          onPressed: () {
            launchURL(Constants.COMPANY_FACEBOOK);
          },
          elevation: 25,
          child: Image(
            color: Constants.THEME_ONE,
            image: AssetImage(
              Constants.ASSETS_ICON_FB,
            ),
            fit: BoxFit.scaleDown,
            height: 75,
            width: 75,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
    final twButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(45.0),
        shadowColor: Constants.THEME_ONE,
        color: Constants.THEME_BASE,
        elevation: 50.0,
        child: MaterialButton(
          minWidth: 40.0,
          height: 40.0,
          onPressed: () {
            launchURL(Constants.COMPANY_TWITTER);
          },
          elevation: 25,
          child: Image(
            color: Constants.THEME_ONE,
            image: AssetImage(
              Constants.ASSETS_ICON_TW,
            ),
            fit: BoxFit.scaleDown,
            height: 75,
            width: 75,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
    final insButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        borderRadius: BorderRadius.circular(45.0),
        shadowColor: Constants.THEME_ONE,
        color: Constants.THEME_BASE,
        elevation: 50.0,
        child: MaterialButton(
          minWidth: 40.0,
          height: 40.0,
          onPressed: () {
            launchURL(Constants.COMPANY_INSTAGRAM);
          },
          elevation: 25,
          child: Image(
            color: Constants.THEME_ONE,
            image: AssetImage(
              Constants.ASSETS_ICON_INS,
            ),
            fit: BoxFit.scaleDown,
            height: 75,
            width: 75,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          vConstants.SL_CONTACT_COMPANY,
          style: new TextStyle(
            fontSize: 25,
            color: Constants.THEME_ONE,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Constants.THEME_BASE,
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Flex(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints.expand(height: 400.00),
                    color: Constants.THEME_BASE,
                    child: Image(
                      image: AssetImage(
                        Constants.ASSETS_LOGO_ONE,
                      ),
                      fit: BoxFit.cover,
                      height: 400,
                      width: 400,
                      alignment: Alignment.center,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[fbButton, insButton, twButton],
                  ),
                ],
                direction: Axis.vertical,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Constants.THEME_BASE,
    );
  }
}
