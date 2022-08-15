// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wiyakm/constants/app_theme.dart';
import 'package:wiyakm/provider/theme_notifier.dart';
import 'myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
