import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wiyakm/webview2.dart';

class MyApp extends StatefulWidget {
  const  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
   Timer(Duration(seconds: 5),()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) { return Web_View2(initialUrl: "https://wiakum.com"); }), (route) => false)) ;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
   return Scaffold(
        body: Center(
          child:  Padding(
            padding:EdgeInsets.all(8.0),
            child: Image.asset("assets/splash-side.gif",
              fit: BoxFit.contain,
            ),
          ),
        )
    );  }

}