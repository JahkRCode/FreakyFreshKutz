import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/calendar_bloc.dart';
import 'package:freakyfreshkutz/blocs/services_bloc.dart';
import 'package:freakyfreshkutz/blocs/users_bloc.dart';
import 'package:freakyfreshkutz/providers/calendar_provider.dart';
import 'package:freakyfreshkutz/providers/services_provider.dart';
import 'package:freakyfreshkutz/providers/users_provider.dart';
import 'package:freakyfreshkutz/screens/login/loginScreen.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

void main() {
  final usersBloc = UsersBloc();
  final servicesBloc = ServicesBloc();
  final calendarBloc = CalendarBloc();
  runApp(MainApp(usersBloc, servicesBloc, calendarBloc));
}

class MainApp extends StatelessWidget {
  final UsersBloc usersBloc;
  final ServicesBloc servicesBloc;
  final CalendarBloc calendarBloc;

  MainApp(this.usersBloc, this.servicesBloc, this.calendarBloc);

  @override
  Widget build(BuildContext context) {
    // ! ***** Hierarchy USERS -> SERVICES -> CALENDAR *****
    return UsersProvider(
      usersBloc: usersBloc,
      child: ServicesProvider(
        servicesBloc: servicesBloc,
        child: CalendarProvider(
          calendarBloc: calendarBloc,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen.navigate(
              name: Constants.ASSETS_ANIM_SPLASH,
              next: LoginScreen(),
              until: () => Future.delayed(Duration(seconds: 0)),
              startAnimation: vConstants.SL_SPLASH,
            ),
          ),
        ),
      ),
    );
  }
}
