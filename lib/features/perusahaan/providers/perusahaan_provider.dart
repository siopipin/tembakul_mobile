import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/perusahaan/models/perusahaan_model.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';
import 'package:tembakul_mobile/utils/global_provider.dart';

enum StatePerusahaan { inital, loading, loaded, nulldata, error }

class PerusahaanProvider extends ChangeNotifier {
  initial() {
    setStatePerusahaan = StatePerusahaan.inital;
    fetchPerusahaan();
  }

  StatePerusahaan _statePerusahaan = StatePerusahaan.inital;
  StatePerusahaan get statePerusahaan => _statePerusahaan;
  set setStatePerusahaan(val) {
    _statePerusahaan = val;
    notifyListeners();
  }

  PerusahaanModel _perusahaanModel = PerusahaanModel();
  PerusahaanModel get dataPerusahaan => _perusahaanModel;
  set setPerusahaanModel(val) {
    _perusahaanModel = val;
    notifyListeners();
  }

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<void> fetchPerusahaan() async {
    setStatePerusahaan = StatePerusahaan.loading;
    var token = await GlobalProvider().getToken();
    final response =
        await _helper.get(url: 'companies', needToken: true, token: token);
    switch (response[0]) {
      case null:
        setStatePerusahaan = StatePerusahaan.error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setStatePerusahaan = StatePerusahaan.loaded;
        setPerusahaanModel = PerusahaanModel.fromJson(json.decode(response[1]));
        break;
      case 401:
        setStatePerusahaan = StatePerusahaan.error;
        Fluttertoast.showToast(msg: "Unauthorised");
        throw UnauthorisedException('Unauthorised');
      default:
        setStatePerusahaan = StatePerusahaan.error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
