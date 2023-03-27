import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/di/di.dart';
import 'package:todo_list/presentation/modules/main/home_page/home_page_screen.dart';

import '../../route/route_list.dart';
import 'home_page/bloc/home_page_bloc.dart';

class MainRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.homePage: (context) {
          return BlocProvider(
            create: (context) =>
                HomePageBloc(prefs: injector.get<SharedPreferences>()),
            child: const HomePageScreen(),
          );
        },
      };
}
