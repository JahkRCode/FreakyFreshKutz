import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class AboutMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          vConstants.SL_ABOUT_COMPANY,
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
                      alignment: Alignment.center,
                    ),
                  ),
                  Text(
                    Constants.ABOUT_ME,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: Constants.THEME_FONT_BASE,
                      color: Constants.THEME_ONE,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
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
