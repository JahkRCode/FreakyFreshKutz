import 'package:flutter/material.dart';
import 'package:freakyfreshkutz/blocs/users_bloc.dart';

class UsersProvider extends InheritedWidget {
  final UsersBloc usersBloc;

  UsersProvider({Key key, this.usersBloc, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static UsersBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(UsersProvider) as UsersProvider)
          .usersBloc;
}
