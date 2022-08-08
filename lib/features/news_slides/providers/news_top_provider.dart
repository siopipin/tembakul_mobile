// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/news_slides/models/news_model.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';

enum StateNewsTop { Initial, Loading, Loaded, Null, Error }

class NewsTopProvider extends ChangeNotifier {
  initial() async {
    setNewsTopState = StateNewsTop.Initial;
    fetchNewsList();
  }

  final ApiBaseHelper _helper = ApiBaseHelper();

  StateNewsTop _newsTopState = StateNewsTop.Initial;
  StateNewsTop get newsTopState => _newsTopState;
  set setNewsTopState(val) {
    _newsTopState = val;
    notifyListeners();
  }

  NewsModel _dataNewsTop = NewsModel();
  NewsModel get dataNewsTop => _dataNewsTop;
  set setDataModel(val) {
    _dataNewsTop = val;
    notifyListeners();
  }

  Future<void> fetchNewsList() async {
    setNewsTopState = StateNewsTop.Loading;
    final response = await _helper.get(url: 'news/top5');
    switch (response[0]) {
      case null:
        setNewsTopState = StateNewsTop.Error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setNewsTopState = StateNewsTop.Loaded;
        setDataModel = NewsModel.fromJson(json.decode(response[1]));
        break;
      case 401:
        setNewsTopState = StateNewsTop.Error;
        Fluttertoast.showToast(msg: "Unauthorised");
        throw UnauthorisedException('Unauthorised');
      default:
        setNewsTopState = StateNewsTop.Error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
