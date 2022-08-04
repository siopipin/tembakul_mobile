import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tembakul_mobile/features/faq/models/faq_model.dart';
import 'package:tembakul_mobile/utils/api_base_helper.dart';
import 'package:tembakul_mobile/utils/app_exceptions.dart';
import 'package:tembakul_mobile/utils/global_provider.dart';

enum StateFAQ { inital, loading, loaded, nulldata, error }

class FAQProvider extends ChangeNotifier {
  initial() {
    setStateFaq = StateFAQ.inital;
    fetchFaq();
  }

  StateFAQ _stateFaq = StateFAQ.inital;
  StateFAQ get stateFaq => _stateFaq;
  set setStateFaq(val) {
    _stateFaq = val;
    notifyListeners();
  }

  FAQModel _faqModel = FAQModel();
  FAQModel get dataFaq => _faqModel;
  set setFaqModel(val) {
    _faqModel = val;
    notifyListeners();
  }

  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<void> fetchFaq() async {
    setStateFaq = StateFAQ.loading;
    var token = await GlobalProvider().getToken();
    final response =
        await _helper.get(url: 'faq', needToken: true, token: token);
    switch (response[0]) {
      case null:
        setStateFaq = StateFAQ.error;
        Fluttertoast.showToast(msg: "Error During Communication");
        throw BadRequestException('Error During Communication');
      case 200:
        setStateFaq = StateFAQ.loaded;
        setFaqModel = FAQModel.fromJson(json.decode(response[1]));
        break;
      case 401:
        setStateFaq = StateFAQ.error;
        Fluttertoast.showToast(msg: "Unauthorised");
        throw UnauthorisedException('Unauthorised');
      default:
        setStateFaq = StateFAQ.error;
        Fluttertoast.showToast(msg: "Invalid Request");
        throw BadRequestException('Invalid Request');
    }
  }
}
