import 'dart:convert';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiyakm/maintenance.dart';
import 'package:wiyakm/navigator.dart';


class API {
  BuildContext context;
String token='1y5lwjuqbohck3ytt1untf5pweaetw5u';
  API(this.context) {
  }

  get(String url) async {
    final String full_url = 'https://wiakum.com/rest/V1/$url';
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
  get_url(String url) async {

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'version': '7.6',

        'Authorization': 'Bearer ${token}',
       // 'locale': Provider.of<Provider_control>(context,listen: false).getlocal(),
      });
      print(response.body);
      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: response.body,
            ));
      } else if (response.statusCode == 404) {
        Nav.route(
            context,
            Maintenance(
              erorr: url + '\n' + response.body,
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      //Nav.route(context, Maintenance());
    } finally {}
  }
  post(String url, Map<String, dynamic> body) async {
    final String full_url =
        'https://wiakum.com/rest/V1/$url';

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("url =${full_url}");
    print("url =${prefs.getString("token")}");
    print("body =${body}");

    try {
      http.Response response = await http.post(Uri.parse(full_url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'version': '7.6',
            'Authorization': 'Bearer ${token }',
           // 'locale': Provider.of<Provider_control>(context,listen: false).getlocal(),
          },
          body: json.encode(body));
      print("body = ${jsonDecode(response.body)}");
      print("statusCode = ${response.statusCode}");

      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr:"${ jsonDecode(response.body)}",
            ));
      } else if (response.statusCode == 404) {
        Nav.route(
            context,
            Maintenance(
              erorr:"${ jsonDecode(response.body)}",
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("$e");
      Nav.route(
          context,
          Maintenance(
            erorr:"$e",
          ));
    } finally {}
  }
  post_url(String url, Map<String, dynamic> body) async {


    final SharedPreferences prefs = await SharedPreferences.getInstance();

    print("body =${url}");
    print("body =${body}");

    try {
      http.Response response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'version': '7.6',

            // 'Authorization': 'Bearer ${token ?? identifier}',
            // 'locale': Provider.of<Provider_control>(context,listen: false).getlocal(),
          },
          body: json.encode(body));
      print("body =${jsonDecode(response.body)}");

      if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr:"${ jsonDecode(response.body)}",
            ));
      } else if (response.statusCode == 404) {
        Nav.route(
            context,
            Maintenance(
              erorr:"${ jsonDecode(response.body)}",
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print("$e");
      Nav.route(
          context,
          Maintenance(
            erorr:"$e",
          ));
    } finally {}
  }
  Put(String url, Map<String, dynamic> body) async {
    final String full_url =
        'https://wiakum.com/rest/V1/$url';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(url);
    try {
      http.Response response = await http.put(Uri.parse(full_url),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token }',
         //   'locale': Provider.of<Provider_control>(context,listen: false).getlocal(),
            'version': '7.6',

          },
          body: json.encode(body));
      print(jsonDecode(response.body));
       if (response.statusCode == 500) {
        Nav.route(
            context,
            Maintenance(
              erorr: jsonDecode(response.body),
            ));
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {} finally {}
  }
}
