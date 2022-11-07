import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list/presentation/app.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'di/di.dart';

Future<dynamic> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  await configureDependencies();
  runApp(const TodoApp());
}
