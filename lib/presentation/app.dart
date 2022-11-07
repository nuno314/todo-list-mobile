import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import '../constants/app_locale.dart';
import 'modules/splash/bloc/splash_bloc.dart';
import 'modules/splash/splash_screen.dart';
import 'route/route.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: RouteGenerator.generateRoute,
      supportedLocales: const [AppLocale.vi, AppLocale.en],
      locale: AppLocale.defaultLocale,
      home: BlocProvider(
        create: (context) => SplashBloc(),
        child: const SplashScreen(),
      ),
    );
  }
}
