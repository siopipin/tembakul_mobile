// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Config {
  final titleApp = "TEMBAKUL";

  //Production
  final urlApi = "https://tembakul.rakadev.my.id/api/mobile/";
  final urlUserImg = "https://tembakul.rakadev.my.id/images/users/";
  final urlNewsImg = "https://tembakul.rakadev.my.id/images/news/";
  final urlAllImg = "https://tembakul.rakadev.my.id/images/all/";

  //Development
  // final urlApi = "http://127.0.0.1:3002/api/mobile/";
  // final urlUserImg = "http://localhost:3002/images/users/";
  // final urlNewsImg = "http://localhost:3002/images/news/";
  // final urlAllImg = "http://localhost:3002/images/all/";

  final padding = 16.0;

  final colorPrimary = const Color(0xff40afff);
  final colorSecondary = const Color(0xff3483c2);
  final colorBg = const Color(0xffeaecee);
  final colorItem = const Color(0xffffffff);

  final fontPrimaryBlack = const Color(0xff051a31);
  final fontPrimaryWhite = const Color(0xffffffff);
  final fontSecondary = const Color(0xffd5eefd);
  final fontBlue = const Color(0xff6cc3ff);

  final shimmerColor = const Color(0xffe0e0e0);

  final fontSizeH1 = 18.0;
  final fontSizeH2 = 16.0;
  final fontSizeH3 = 14.0;
  final fontSizeTiny = 12.0;

  //date format
  final dateFormat = DateFormat('EEE, dd-MM-yyyy');
}
