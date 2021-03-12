import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/services_bloc.dart';

class ServicesProvider extends InheritedWidget {
  final ServicesBloc servicesBloc;

  ServicesProvider({Key key, this.servicesBloc, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ServicesBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ServicesProvider)
              as ServicesProvider)
          .servicesBloc;
}
