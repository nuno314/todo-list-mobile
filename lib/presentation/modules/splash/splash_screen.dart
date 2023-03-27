// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/presentation/modules/splash/bloc/splash_bloc.dart';
import 'package:todo_list/presentation/route/route_list.dart';
import 'package:todo_list/theme/theme_color.dart';

part 'splash_action.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    initial();
    super.initState();
  }

  SplashBloc get bloc => BlocProvider.of<SplashBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeColor.primaryColor,
      body: BlocListener<SplashBloc, SplashState>(
        listener: _blocListener,
        child: const Text('19120682'),
      ),
    );
  }
}
