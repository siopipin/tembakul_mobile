import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/penerima/models/penerima_detail_model.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';
import 'package:tembakul_mobile/utils/global_provider.dart';

enum StatePenerimaDetail { inital, loading, loaded, nulldata, error }

class PenerimaDetailProvider extends ChangeNotifier {
  initial({required String idPenerima}) {
    setStatePenerimaDetail = StatePenerimaDetail.inital;
    fetchPenerimaDetail(idPenerima: idPenerima);
  }

  StatePenerimaDetail _statePenerimaDetail = StatePenerimaDetail.inital;
  StatePenerimaDetail get statePenerimaDetail => _statePenerimaDetail;
  set setStatePenerimaDetail(val) {
    _statePenerimaDetail = val;
    notifyListeners();
  }

  PenerimaDetailModel _penerimaDetailModel = PenerimaDetailModel();
  PenerimaDetailModel get dataPenerimaDetail => _penerimaDetailModel;
  set setPenerimaDetailModel(val) {
    _penerimaDetailModel = val;
    notifyListeners();
  }

  final ApiBaseHelper _helper = ApiBaseHelper();
  Future<void> fetchPenerimaDetail({required String idPenerima}) async {
    setStatePenerimaDetail = StatePenerimaDetail.loading;
    var token = await GlobalProvider().getToken();
    final response = await _helper.get(
        url: 'hibah/$idPenerima', needToken: true, token: token);
    switch (response[0]) {
      case null:
        setStatePenerimaDetail = StatePenerimaDetail.error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setStatePenerimaDetail = StatePenerimaDetail.loaded;
        setPenerimaDetailModel =
            PenerimaDetailModel.fromJson(json.decode(response[1]));
        break;
      case 401:
        setStatePenerimaDetail = StatePenerimaDetail.error;
        Fluttertoast.showToast(msg: "Unauthorised");
        throw UnauthorisedException('Unauthorised');
      default:
        setStatePenerimaDetail = StatePenerimaDetail.error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
