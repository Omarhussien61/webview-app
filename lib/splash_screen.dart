import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiyakm/navigator.dart';
import 'package:wiyakm/webview2.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(milliseconds: 2800), () => Nav.route(context, Web_View2()));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Center(
          child:  Padding(
            padding:EdgeInsets.all(8.0),
            child: Image.asset("assets/splash-side.gif",
              fit: BoxFit.contain,
            ),
          ),
        )
    );
  }
}
