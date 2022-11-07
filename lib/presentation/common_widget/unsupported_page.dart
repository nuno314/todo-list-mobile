import 'package:flutter/material.dart';

class UnsupportedPage extends StatelessWidget {
  final String? title;
  final String? msg;
  const UnsupportedPage({Key? key, this.title, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Tính năng đang được phát triển',
        ),
      ),
    );
  }
}
