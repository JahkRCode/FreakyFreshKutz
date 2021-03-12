import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/users_bloc.dart';
import 'package:freakyfreshkutz/screens/login/loginScreen.dart';
import 'package:share/share.dart';

// ! ***** SCREENS FOR NAVIGATION *****/
import './galleryScreen.dart';
import 'package:freakyfreshkutz/screens/userClientScreen.dart';
import 'package:freakyfreshkutz/screens/userServicesScreen.dart';
import './contactMeScreen.dart';
import './aboutMeScreen.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class UserHomeScreen extends StatefulWidget {
  final DocumentReference currentUser;
  UserHomeScreen({Key key, this.currentUser}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  String nextAppt = 'Book IT!';
  String fnlName = '';
  String appLink;
  // ! ***** Admob Initializing *****
  InterstitialAd interstitialAd;
  String adID;
  String appID;
  var bloc = UsersBloc();

  Future<LoginScreen> _signOut() async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pop();
    return Navigator.of(context).push(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => LoginScreen()));
  }

  InterstitialAd myInterstitial() {
    return InterstitialAd(
      adUnitId: this.adID,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          interstitialAd..load();
        } else if (event == MobileAdEvent.clicked) {
          bloc.updateData(
              widget.currentUser.documentID, vConstants.ADS_CLICKED, 1);
        } else if (event == MobileAdEvent.closed) {
          interstitialAd = myInterstitial()..load();
        }
      },
    );
  }

  static MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: Constants.AD_KEYWORDS,
    contentUrl: Constants.COMPANY_INSTAGRAM,
    childDirected: false,
  );

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      adID = Constants.IOS_AD_ID;
      appID = Constants.IOS_APP_ID;
      appLink = Constants.IOS_APP_LINK;
    } else if (Platform.isAndroid) {
      adID = Constants.ANDROID_AD_ID;
      appID = Constants.ANDROID_APP_ID;
      appLink = Constants.ANDROID_APP_LINK;
    }
    FirebaseAdMob.instance.initialize(appId: this.appID);
    interstitialAd = myInterstitial()..load();
  }

  @override
  void dispose() {
    interstitialAd?.dispose();
    nextAppt = '';
    fnlName = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.widget.currentUser.get().then((DocumentSnapshot ds) {
      setState(() {
        this.fnlName = ds[vConstants.FIRST_NAME];
        ds.data[vConstants.APPOINTMENTS] != null
            ? this.nextAppt = ds[vConstants.APPOINTMENTS].toString()
            : this.nextAppt = ds[vConstants.APPOINTMENTS].toString();
      });
    });
    // ! ***** HEADER ITEMS *****/
    var headerLogo = DecorationImage(
      image: AssetImage(
        Constants.ASSETS_LOGO_ONE,
      ),
      fit: BoxFit.cover,
    );
    var profileName = Text(
      '${vConstants.DL_PROFILE} ${this.fnlName}',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 15,
        color: Constants.THEME_ONE,
        fontWeight: FontWeight.bold,
      ),
    );
    var nextAppointment = Text(
      '${vConstants.DL_NEXT_APPOINTMENT} ${this.nextAppt}',
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 15,
        color: Constants.THEME_ONE,
        fontWeight: FontWeight.bold,
      ),
    );

    // ! ***** HEADER OBJECT *****/
    var header = DrawerHeader(
      padding: EdgeInsets.fromLTRB(63.0, 63.0, 63.0, 10.0),
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        alignment: Alignment.center,
      ),
      decoration: BoxDecoration(
          image: headerLogo,
          color: Constants.THEME_BASE,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Constants.THEME_ONE,
              offset: Offset(0.0, 0.0),
            )
          ]),
    );

    // ! ***** DRAWER ITEMS *****/
    var services = ListTile(
        title: Text(
          vConstants.DL_SERVICES,
          style: TextStyle(color: Constants.THEME_ONE),
        ),
        trailing: Icon(
          Icons.list,
          color: Constants.THEME_ONE,
        ),
        onTap: () {
          interstitialAd
            ..load()
            ..show();
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => UserServices(
                    currentUser: widget.currentUser,
                  )));
        });

    var gallery = ListTile(
        title: Text(
          vConstants.DL_GALLERY,
          style: TextStyle(color: Constants.THEME_ONE),
        ),
        trailing: Icon(
          Icons.panorama,
          color: Constants.THEME_ONE,
        ),
        onTap: () {
          interstitialAd
            ..load()
            ..show();
          Navigator.of(context).pop();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => Gallery()));
        });
    var aboutme = ListTile(
        title: Text(
          vConstants.DL_ABOUT_ME,
          style: TextStyle(color: Constants.THEME_ONE),
        ),
        trailing: Icon(
          Icons.info_outline,
          color: Constants.THEME_ONE,
        ),
        onTap: () {
          interstitialAd
            ..load()
            ..show();
          Navigator.of(context).pop();
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => AboutMe()));
        });
    var loyaltyprogram = ListTile(
        title: Text(
          vConstants.DL_MY_INFO,
          style: TextStyle(color: Constants.THEME_ONE),
        ),
        trailing: Icon(
          Icons.redeem,
          color: Constants.THEME_ONE,
        ),
        onTap: () {
          interstitialAd
            ..load()
            ..show();
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) =>
                  UserClient(currentUser: widget.currentUser)));
        });
    var contactme = ListTile(
        title: Text(
          vConstants.DL_CONTACT_ME,
          style: TextStyle(color: Constants.THEME_ONE),
        ),
        trailing: Icon(
          Icons.contact_mail,
          color: Constants.THEME_ONE,
        ),
        onTap: () {
          interstitialAd
            ..load()
            ..show();
          Navigator.of(context).pop();
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ContactMe()));
        });
    var refertofriend = ListTile(
        title: Text(
          vConstants.DL_REFER_TO_FRIEND,
          style: TextStyle(color: Constants.THEME_ONE),
        ),
        trailing: Icon(
          Icons.perm_phone_msg,
          color: Constants.THEME_ONE,
        ),
        onTap: () {
          // TODO: Add App links based on application
          //final RenderBox box = context.findRenderObject();
          Share.share(
            this.appLink,
            subject: vConstants.DL_SHARE_SUBJECT,
          );
        });
    var signOut = ButtonBar(
      alignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        MaterialButton(
          child: Text(
            vConstants.BL_SIGN_OUT,
            style: TextStyle(
                fontSize: 15,
                color: Constants.THEME_ONE,
                fontStyle: FontStyle.italic),
          ),
          onPressed: () {
            _signOut();
          },
        )
      ],
    );

    // ! ***** DRAWER OBJECT *****/
    var drawer = Drawer(
        child: Container(
            color: Constants.THEME_BASE,
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      color: Constants.THEME_BASE,
                      child: Column(
                        children: <Widget>[
                          header,
                          profileName,
                          nextAppointment,
                          Divider(),
                          services,
                          gallery,
                          loyaltyprogram,
                          refertofriend,
                          aboutme,
                          contactme,
                          Divider(),
                          signOut,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )));

    // ! ***** RETURN OBJECT *****/
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "",
          style: TextStyle(
            fontSize: 25,
            color: Constants.THEME_ONE,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Constants.THEME_ONE),
        backgroundColor: Constants.THEME_BASE,
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),
      drawer: drawer,
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Material(
                  borderRadius: BorderRadius.circular(360.0),
                  color: Constants.THEME_BASE,
                  elevation: 50.0,
                  child: Image(
                    colorBlendMode: BlendMode.hardLight,
                    image: AssetImage(Constants.ASSETS_LOGO_TWO),
                    fit: BoxFit.contain,
                    height: 500,
                    width: 500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Constants.THEME_BASE,
    );
  }
}
