// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiyakm/constants/app_theme.dart';
import 'package:wiyakm/provider/theme_notifier.dart';
import 'package:wiyakm/screens/myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FCMConfig.instance.init(
      defaultAndroidForegroundIcon: '@mipmap/ic_launcher', //default is @mipmap/ic_launcher
      defaultAndroidChannel: AndroidNotificationChannel(
        'high_importance_channel', // same as value from android setup
        'Fcm config',
        importance: Importance.high,
        sound: RawResourceAndroidNotificationSound('notification'),
      ),
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');

  // Set the background messaging handler early on, as a named top-level function
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  try {
    var token = await FirebaseMessaging.instance.getToken();
    print("fcm token $token");
  } catch (e) {
    print(e.toString());
  }
  SharedPreferences.getInstance().then((prefs) {
    String local = 'ar';
    if (prefs.getString('local') != null) {
      local = prefs.getString('local')!;
    }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<Provider_control>(
      create: (_) => Provider_control(local),
    ),
  ],child: MyApp(),

  ),


      );  });

}
