
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wiyakm/constants/colors.dart';
import 'package:wiyakm/constants/strings.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _searching = false;
  ScrollController controller = new ScrollController();
  bool notificationFlag = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      appBar:  AppBar(
        title: Text("Account"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Column(
              children: [
                Center(
                    heightFactor: 1.5,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(Strings.GUEST_IMAGE),
                      radius: 50,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("user_name"),
                      SizedBox(width: 8),
                      Text("last name", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("email"),
                      SizedBox(width: 8),
                      Text("omar@hussien61@com", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
            // information personal
            Visibility(
              child: Column(
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(8.0),
                      child: Text("information_account",
                          style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor, fontSize: 13),
                          textAlign: TextAlign.start)),
                  ListTile(
                    leading: Container(
                        width: 20,
                        height: 20,
                        child: Icon(Icons.wrong_location)),
                    title: Text("addresses", style: TextStyle(fontSize: 13)),
                    trailing: Icon( Icons.keyboard_arrow_left ),
                    onTap: () {

                    },
                  ),

                ],
              ),
            ),
            // Services
          ],
        ),
      ),
    );
  }
}
