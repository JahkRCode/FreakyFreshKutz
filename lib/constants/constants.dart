library constants;

import 'package:flutter/material.dart';

// ! ***** Constants: import 'package:freakyfreshkutz/constants/constants.dart' as Constants; *****
// ! ** Colors
// ! ** PII Text
// ! ** API KEYS
// ! ** Assets' Paths

// ! ***** CLIENT INFO *****
const String COMPANY_NAME = 'Freaky Fresh Kutz';
const String ABOUT_ME = """
If It Ain't Freaky It Aint Fresh! 
Thank you for downloading the Official Freaky Fresh Kutz App. 
We are dedicated to changing faces, lives, and perceptions with our Freaky Fresh Kutz. 
Book your appointment like never before and truly experience what this Kutting edge tonsorial artist can do for you. 
""";
const String COMAPNY_EMAIL = 'freakyfreshkutz@gmail.com';
const String COMPANY_PHONE_NUMBER = '(313) 204-5848';
const String COMPANY_ADDRESS = '138 Cadillac Sq\nDetroit, Michigan';
const String COMPANY_TWITTER = 'https://www.twitter.com/freakyfreshkutz';
const String COMPANY_FACEBOOK = 'https://www.facebook.com/FreakyFreshKutz';
const String COMPANY_INSTAGRAM = 'https://www.instagram.com/freakyfreshkutz';

// ! ***** THEME COLORS & FONT *****
// ! *** Odd Number Themes = Accents
// ! *** Even Number Themes = Color

const Color CARD_THEME_BASE = Colors.black87;
const Color THEME_BASE = Colors.black;

const MaterialAccentColor THEME_ONE = Colors.lightGreenAccent;
const MaterialColor THEME_TWO = Colors.lightGreen;
const MaterialAccentColor THEME_THREE = Colors.greenAccent;
const MaterialColor THEME_FOUR = Colors.green;
const MaterialAccentColor THEME_FIVE = Colors.yellowAccent;
const MaterialColor THEME_SIX = Colors.yellow;
const MaterialAccentColor THEME_SEVEN = Colors.redAccent;
const MaterialColor THEME_EIGHT = Colors.amber;

const MaterialColor DEBUG_COLOR = Colors.pink;
const String THEME_FONT_BASE = 'Arial';

// ! ***** ASSETS PATHS *****
const String ASSETS_LOGO_ONE = 'lib/assets/logo/BACKlogo.png';
const String ASSETS_LOGO_TWO = 'lib/assets/logo/logoSM.png';
const String ASSETS_ICON_FB = 'lib/assets/icons/fb.png';
const String ASSETS_ICON_TW = 'lib/assets/icons/tw.png';
const String ASSETS_ICON_INS = 'lib/assets/icons/ins.png';
const String ASSETS_ANIM_SPLASH = 'lib/assets/splash/splash.flr';

// ! ***** AD Variables *****
const List<String> AD_KEYWORDS = [
  'black',
  'black owned',
  'beauty',
  'tonsorial',
  'barber',
  'salon',
  'hair',
  'moisturizer',
  'fashion',
  'african'
];
const String IOS_AD_ID = 'ca-app-pub-5129534325274948/4912260224';
const String IOS_APP_ID = 'ca-app-pub-5129534325274948~2956821357';
const String IOS_APP_LINK =
    'https://apps.apple.com/us/app/freaky-fresh-kutz/id1478318226';
const String ANDROID_AD_ID = 'ca-app-pub-5129534325274948/8823585072';
const String ANDROID_APP_ID = 'ca-app-pub-5129534325274948~5522634317';
const String ANDROID_APP_LINK =
    'https://play.google.com/store/apps/details?id=com.safires.freakyfreshkutz';

// ! ***** SQUARE INFO *****
const String SQ_HOST_URL = 'https://connect.squareup.com/v2/payments';
const String SQ_APPLICATION_ID = 'sq0idp-ubQgrniliEfM5jHwWiGt0w';
const String SQ_API_KEY =
    'EAAAEBnOlCstQ-khQ_prRGAfigF-In68RJw7TOoPZKsgEiQiXsR9XjOwyLATq2zw';
const String SQ_LOCATION_ID = '5MDPB860T5B1F';
const String SQ_CURRENCY = 'USD';
const double SQ_DEV_CUT = 0.022;
const SQ_HEADER = {
  "Accept": "application/json",
  "content-type": "application/json",
  "Authorization": "Bearer $SQ_API_KEY"
};
