import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/penerima/models/penerima_model.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';
import 'package:tembakul_mobile/utils/global_provider.dart';

enum StatePenerima { inital, loading, loaded, nulldata, error }

class PenerimaProvider extends ChangeNotifier {
  initial() {
    setStatePenerima = StatePenerima.inital;
    fetchPenerimaList();
  }

  StatePenerima _statePenerima = StatePenerima.inital;
  StatePenerima get statePenerima => _statePenerima;
  set setStatePenerima(val) {
    _statePenerima = val;
    notifyListeners();
  }

  PenerimaModel _penerimaModel = PenerimaModel();
  PenerimaModel get penerimaData => _penerimaModel;
  set setPenerimaModel(val) {
    _penerimaModel = val;
    notifyListeners();
  }

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<void> fetchPenerimaList() async {
    setStatePenerima = StatePenerima.loading;
    var token = await GlobalProvider().getToken();
    final response =
        await _helper.get(url: 'hibah', needToken: true, token: token);
    switch (response[0]) {
      case null:
        setStatePenerima = StatePenerima.error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setStatePenerima = StatePenerima.loaded;
        setPenerimaModel = PenerimaModel.fromJson(json.decode(response[1]));
        break;
      case 401:
        setStatePenerima = StatePenerima.error;
        Fluttertoast.showToast(msg: "Unauthorised");
        throw UnauthorisedException('Unauthorised');
      default:
        setStatePenerima = StatePenerima.error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
