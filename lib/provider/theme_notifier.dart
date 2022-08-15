import 'package:flutter/material.dart';
import 'package:wiyakm/constants/strings.dart';

class Provider_control with ChangeNotifier {
  String local ='ar';
  String? baseUrl=Strings.MAIN_URL ;
  Provider_control(this.local);
  getlocal() => local;
  getBaseUrl() => local=='ar'?Strings.MAIN_API_URL_AR:Strings.MAIN_API_URL_EN;
  setLocal(String st) {
    local = st;
    notifyListeners();
  }


}
