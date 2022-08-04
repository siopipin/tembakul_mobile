import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/unggulan/models/unggulan_model.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';
import 'package:tembakul_mobile/utils/global_provider.dart';

enum StateUnggulan { inital, loading, loaded, nulldata, error }

class UnggulanProvider extends ChangeNotifier {
  initial() {
    setStateUnggulan = StateUnggulan.inital;
    fetchUnggulan();
  }

  StateUnggulan _stateUnggulan = StateUnggulan.inital;
  StateUnggulan get stateUnggulan => _stateUnggulan;
  set setStateUnggulan(val) {
    _stateUnggulan = val;
    notifyListeners();
  }

  UnggulanModel _unggulanModel = UnggulanModel();
  UnggulanModel get dataUnggulan => _unggulanModel;
  set setUnggulanModel(val) {
    _unggulanModel = val;
    notifyListeners();
  }

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<void> fetchUnggulan() async {
    setStateUnggulan = StateUnggulan.loading;
    var token = await GlobalProvider().getToken();
    final response =
        await _helper.get(url: 'unggulan', needToken: true, token: token);
    switch (response[0]) {
      case null:
        setStateUnggulan = StateUnggulan.error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setStateUnggulan = StateUnggulan.loaded;
        setUnggulanModel = UnggulanModel.fromJson(json.decode(response[1]));
        break;
      case 401:
        setStateUnggulan = StateUnggulan.error;
        Fluttertoast.showToast(msg: "Unauthorised");
        throw UnauthorisedException('Unauthorised');
      default:
        setStateUnggulan = StateUnggulan.error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
