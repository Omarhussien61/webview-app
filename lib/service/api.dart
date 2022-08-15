import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiyakm/maintenance.dart';
import 'package:wiyakm/navigator.dart';
import 'package:wiyakm/provider/theme_notifier.dart';

import '../constants/strings.dart';


class API {
  BuildContext context;
String token='1y5lwjuqbohck3ytt1untf5pweaetw5u';
  API(this.context) {

  }

  get(String url) async {
    final model = Provider.of<Provider_control>(context,listen: false);

    final String full_url = '${model.local=='ar'?Strings.MAIN_API_AR:Strings.MAIN_API_EN}$url';
    print(full_url);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(token);

    try {
      http.Response response = await http.get(Uri.parse(full_url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'version': '7.6',
        'Authorization': 'Bearer ${token }',
      //  'locale': Provider.of<Provider_control>(context,listen: false).getlocal(),
      });
      print(jsonDecode(response.body));
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: response.body,
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("$e");
      Nav.route(context, Maintenance(erorr: '$e',));
    } finally {}
  }

}
