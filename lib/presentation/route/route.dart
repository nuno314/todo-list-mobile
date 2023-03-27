import 'package:flutter/cupertino.dart';

import '../common_widget/unsupported_page.dart';
import '../modules/main/main_route.dart';
import '../modules/splash/splash_route.dart';

class RouteGenerator {
  static Map<String, WidgetBuilder> _getAll(RouteSettings settings) => {
        ...WelcomeRoute.getAll(settings),
        ...MainRoute.getAll(settings),
      };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final builder = _getAll(settings)[settings.name!];

    return buildRoute(
      builder ?? (context) => const UnsupportedPage(),
      settings: settings,
    );
  }
}

Route buildRoute<T>(WidgetBuilder builder, {RouteSettings? settings}) {
  return CupertinoPageRoute<T>(
    builder: (context) => builder(context),
    settings: settings,
  );
}
