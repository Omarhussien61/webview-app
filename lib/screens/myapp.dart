import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:wiyakm/provider/theme_notifier.dart';
import 'package:wiyakm/screens/splash_screen.dart';


class MyApp extends StatefulWidget {
  static void setlocal(BuildContext context, Locale locale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setlocal(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setlocal(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
     FirebaseMessaging.instance.setAutoInitEnabled(true);

    _locale =
        Locale(Provider.of<Provider_control>(context, listen: false).local, "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Provider.of<Provider_control>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      localizationsDelegates: [
       // AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      localeResolutionCallback: (devicelocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == devicelocale?.languageCode &&
              locale.countryCode == devicelocale?.countryCode) {
            return devicelocale;
          }
        }
        return supportedLocales.first;
      },
      supportedLocales: [
        Locale("en", ""),
        Locale("ar", ""),
      ],
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
        primaryColor:Colors.deepOrangeAccent,
        appBarTheme: AppBarTheme(color: Colors.deepOrangeAccent),
        fontFamily: 'Cairo',

        snackBarTheme: SnackBarThemeData(
          backgroundColor:Colors.deepOrangeAccent,
          behavior: SnackBarBehavior.floating,

        ),
      ),
      home: SplashScreen(),
    );
  }
}