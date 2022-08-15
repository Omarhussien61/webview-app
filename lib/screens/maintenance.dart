import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Maintenance extends StatefulWidget {
  String? erorr;

  Maintenance({this.erorr});

  @override
  _MaintenanceState createState() => _MaintenanceState();
}

class _MaintenanceState extends State<Maintenance> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(
        "عطل فنى",
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      actions: [
        InkWell(
          onTap: () {

          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.login_outlined,
              size: 25,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
      body: SingleChildScrollView(
        child: Container(child: Center(child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 50,),
              Image.asset("assets/images/onb2.png"),
              SizedBox(height: 50,),
              Center(child: Text("نشكرك على .... ونعتذر عن الخطأ الحاصل في الاتصال حاليا ، حاول بعد قليل",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),textAlign: TextAlign.center,))
            ],
          ),
        ))),
      ),
    );
  }
}
