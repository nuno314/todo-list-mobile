import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../di/di.dart';

ThemeColor get themeColor => injector.get<ThemeColor>();

@injectable
class ThemeColor {
  final white = Colors.white;
  final transparent = Colors.transparent;
  final primaryColor = const Color(0xFF5F9EA0);

  final primaryColorLight = const Color(0xFF7fb1d3);
  final lightGray = const Color(0xFFEAE9E9);

  final cardBackground = const Color(0xFFf7f8f8);
  final scaffoldBackgroundColor = const Color(0xFFF6F7FB);
  Color get iconSelected => primaryColor;
  final iconUnselected = Colors.grey;
  final lightGrey = const Color(0xFFbebebe);
  final greyDC = const Color(0xFFdcdcdc);
  final black = const Color(0xFF000000);
  final greyE5 = const Color(0xFFE5E5E5);

  //HEX code color
  final colorFBFBFB = const Color(0xFFFBFBFB);
  final colorF3F3F3 = const Color(0xFFF3F3F3);
  final colorF0F0F5 = const Color(0xFFF0F0F5);
  final colorECEEF3 = const Color(0xffECEEF3);
  final colorE6E6EB = const Color(0xFFE6E6EB);
  final color8C8C8C = const Color(0xFF8C8C8C);
  final color8D8D94 = const Color(0xFF8D8D94);
  final color646464 = const Color(0xFF646464);
  final colorFF7D43 = const Color(0xFFFF7D43);
  final colorD9AF62 = const Color(0xFFD9AF62);
  final colorA260FF = const Color(0xFFA260FF);
  final colorA66EFA = const Color(0xFFA66EFA);
  final color08A2FF = const Color(0xFF08A2FF);
  final colorFAF3E6 = const Color(0xFFFAF3E6);
  final color05B340 = const Color(0xFF05B340);
  final colorEE1602 = const Color(0xFFEE1602);
  final color828282 = const Color(0xFF828282);
  final colorFF558E = const Color(0xFFFF558E);
  final colorFFDECF = const Color(0xFFFFDECF);
  final color33B650 = const Color(0xFF33B650);
  final colorC5E9CA = const Color(0xFFC5E9CA);
  final colorFF9A05 = const Color(0xFFFF9A05);
  final colorFFF7EB = const Color(0xFFFFF7EB);
  final colorE7F6E9 = const Color(0xFFE7F6E9);
  final colorAB7E40 = const Color(0xFFAB7E40);

  final inactiveColor = const Color(0xFF111111);
  Color get activeColor => primaryColor;
  final warningTextColor = const Color(0xFFFF9B1A);

  final titleMenu = Colors.grey;
  final primaryIcon = Colors.grey;
  final green = const Color(0xFF4d9e53);
  final red = const Color(0xFFfb4b53);
  final orange = const Color(0xFFff9b1a);
  final darkBlue = const Color(0xFF002d41);

  //light
  Color get primaryText => color272729;
  final subText = const Color(0xFF767676);
  final fillColorTextField = const Color(0xFFF0F0F0);
  final linkText = const Color(0xFF3680D8);

  //dart
  final primaryDarkText = Colors.black;
  final subDarkText = Colors.grey;
  final text = const Color(0xFF666666);

  final gallery = const Color(0xFFEFEFEF);
  final grayF6F7FB = const Color(0xFFF6F7FB);
  final grayAD = const Color(0xFFADADAD);
  final grayE3 = const Color(0xFFE3E3E3);
  final gray8C = const Color(0xFF8C8C8C);
  final color272729 = const Color(0xFF272727);
  final color272727 = const Color(0xFF272727);
  final color735329 = const Color(0xFF735329);
  final colore6e6e6 = const Color(0xFFE6E6E6);

  final colorCCECF9 = const Color(0xFFCCECF9);
  final color56C7FC = const Color(0xFF56C7FC);
  final color304FFE = const Color(0xFF304FFE);
  final grey8C8C8C = const Color(0xFF8C8C8C);
  final grey8D8D94 = const Color(0xFF8D8D94);
  final lightRed = const Color(0xFFFFE2DF);
  final veryLightRed = const Color(0xFFDE2C00);
  final lightGreen = const Color(0xFFE7F6E9);
  final orangeE65501 = const Color(0xFFE65501);
  final color67C13C = const Color(0xFF67C13C);
}
