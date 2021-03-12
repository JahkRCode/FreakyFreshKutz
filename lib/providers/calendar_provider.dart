import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/calendar_bloc.dart';

class CalendarProvider extends InheritedWidget {
  final CalendarBloc calendarBloc;

  CalendarProvider({Key key, this.calendarBloc, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CalendarBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(CalendarProvider)
              as CalendarProvider)
          .calendarBloc;
}
