import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../route/route_list.dart';
import 'bloc/splash_bloc.dart';
import 'splash_screen.dart';

class WelcomeRoute {
  static Map<String, WidgetBuilder> getAll(RouteSettings settings) => {
        RouteList.initial: (context) => BlocProvider(
              create: (context) => SplashBloc(),
              child: const SplashScreen(),
            ),
      };
}
