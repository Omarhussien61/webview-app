// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:wiyakm/constants/app_theme.dart';
import 'myapp.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale("ar", ""),
      localeResolutionCallback: (devicelocale, supportedLocales) {
        // for (var locale in supportedLocales) {
        //   if (locale.languageCode == devicelocale.languageCode &&
        //       locale.countryCode == devicelocale.countryCode) {
        //     return devicelocale;
        //   }
        // }
        return supportedLocales.first;
      },
      supportedLocales: [
        Locale("ar", ""),
      ],
      home: MyApp(), theme: themeData));
}
