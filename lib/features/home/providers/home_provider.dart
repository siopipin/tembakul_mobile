import 'package:flutter/material.dart';
import 'package:tembakul_mobile/utils/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  initial() async {
    setIsLoggedIn = false;
    userInfo();
  }

  SharedData data = SharedData();

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  set setIsLoggedIn(val) {
    _isLoggedIn = val;
    notifyListeners();
  }

  String _name = "";
  String get name => _name;
  set setName(val) {
    _name = val;
    notifyListeners();
  }

  userInfo() async {
    await data.showToken().then((value) {
      if (value == null) {
        setIsLoggedIn = false;
      } else {
        setIsLoggedIn = true;
      }
    });

    await data.showNama().then((value) {
      if (value == null) {
        setName = "User";
      } else {
        setName = value;
      }
    });
  }
}
