import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';

enum StateRegister { initial, loading, loaded, nulldata, error }

class RegisterProvider extends ChangeNotifier {
  initial() {
    ctrlNama.clear();
    ctrlHP.clear();
    ctrlPassword.clear();
  }

  //Form
  TextEditingController ctrlNama = TextEditingController();
  TextEditingController ctrlHP = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();

  StateRegister _registerState = StateRegister.initial;
  StateRegister get stateRegister => _registerState;
  set setStateRegister(val) {
    _registerState = val;
    notifyListeners();
  }

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<void> postRegister(
      {required String hp,
      required String password,
      required String nama}) async {
    setStateRegister = StateRegister.loading;
    var data = {"hp": hp, "password": password, "name": nama};
    final response = await _helper.post(url: 'auth/register', data: data);
    switch (response[0]) {
      case null:
        setStateRegister = StateRegister.error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setStateRegister = StateRegister.loaded;
        Fluttertoast.showToast(msg: "Pendaftaran Berhasil, silahkan login!");

        //Bersihkan data
        ctrlHP.clear();
        ctrlPassword.clear();
        ctrlNama.clear();
        break;
      case 404:
        setStateRegister = StateRegister.error;
        Fluttertoast.showToast(msg: "Pendaftaran gagal, coba lagi!");
        throw UnauthorisedException('Unauthorised');
      default:
        setStateRegister = StateRegister.error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
