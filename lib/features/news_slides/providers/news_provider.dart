// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/news_slides/models/news_model.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';

enum NewsState { Initial, Loading, Loaded, Null, Error }

class NewsProvider extends ChangeNotifier {
  initial() async {
    setNewsState = NewsState.Initial;
    fetchNewsList();
  }

  final ApiBaseHelper _helper = ApiBaseHelper();

  NewsState _newsState = NewsState.Initial;
  NewsState get newsState => _newsState;
  set setNewsState(val) {
    _newsState = val;
    notifyListeners();
  }

  NewsModel _dataNews = NewsModel();
  NewsModel get dataNews => _dataNews;
  set setDataModel(val) {
    _dataNews = val;
    notifyListeners();
  }

  Future<void> fetchNewsList() async {
    setNewsState = NewsState.Loading;
    final response = await _helper.get(url: 'news');
    switch (response[0]) {
      case null:
        setNewsState = NewsState.Error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setNewsState = NewsState.Loaded;
        setDataModel = NewsModel.fromJson(json.decode(response[1]));
        break;
      case 401:
        setNewsState = NewsState.Error;
        Fluttertoast.showToast(msg: "Unauthorised");
        throw UnauthorisedException('Unauthorised');
      default:
        setNewsState = NewsState.Error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
