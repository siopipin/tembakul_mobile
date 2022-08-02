// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';
import 'package:http/http.dart';
import 'package:tembakul_mobile/utils/config.dart';

class ApiBaseHelper {
  Client http = Client();
  Future<dynamic> get({required String url}) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(Config().urlApi + url));
      responseJson = [response.statusCode, response.body];
    } on SocketException {
      responseJson = [null, null];
    }

    return responseJson;
  }

  Future<dynamic> post({required String url, required var data}) async {
    var responseJson;
    try {
      final response =
          await http.post(Uri.parse(Config().urlApi + url), body: data);
      responseJson = [response.statusCode, response.body];
    } on SocketException {
      responseJson = [null, null];
    }

    return responseJson;
  }
}
