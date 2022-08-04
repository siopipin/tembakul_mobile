import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/auth/models/login_model.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';
import 'package:tembakul_mobile/utils/shared_preferences.dart';

enum LoginState { Initial, Loading, Loaded, Null, Error }

class LoginProvider extends ChangeNotifier {
  initial() {
    ctrlHP.clear();
    ctrlPassword.clear();
    setLoginState = LoginState.Initial;
  }

  //Form
  TextEditingController ctrlHP = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();

  //Login Action
  final ApiBaseHelper _helper = ApiBaseHelper();
  LoginState _loginState = LoginState.Initial;
  LoginState get loginState => _loginState;
  set setLoginState(val) {
    _loginState = val;
    notifyListeners();
  }

  LoginModel _dataLogin = LoginModel();
  LoginModel get dataLogin => _dataLogin;
  set setDataModel(val) {
    _dataLogin = val;
    notifyListeners();
  }

  Future<void> postLogin({required String hp, required String password}) async {
    setLoginState = LoginState.Loading;
    var data = {"hp": hp, "password": password};
    final response = await _helper.post(url: 'auth/login', data: data);
    switch (response[0]) {
      case null:
        setLoginState = LoginState.Error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setLoginState = LoginState.Loaded;
        setDataModel = LoginModel.fromJson(json.decode(response[1]));

        //Bersihkan data
        ctrlHP.clear();
        ctrlPassword.clear();

        await SharedData().saveLogin(
            id: dataLogin.data!.id.toString(),
            nama: dataLogin.data!.name!,
            token: dataLogin.data!.token!);

        break;
      case 404:
        setLoginState = LoginState.Error;
        Fluttertoast.showToast(msg: "Kata sandi salah, coba lagi!");
        throw UnauthorisedException('Unauthorised');
      default:
        setLoginState = LoginState.Error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
