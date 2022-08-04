import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/shared_preferences.dart';

class GlobalProvider extends ChangeNotifier {
  SharedData data = SharedData();

  Future<String> getID() async {
    String val = '';
    await data.showId().then((value) {
      if (value == null) {
        val = '';
      } else {
        val = value;
      }
    });
    return val;
  }

  Future<String> getToken() async {
    String val = '';
    await data.showToken().then((value) {
      if (value == null) {
        val = '';
      } else {
        val = value;
      }
    });
    return val;
  }
}
