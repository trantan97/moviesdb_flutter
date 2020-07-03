import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moviesdb/src/locator.dart';
import 'package:moviesdb/src/ui/screens/screens.dart';
import 'package:moviesdb/src/utils/utils.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      localizationsDelegates: [
        const LanguageDelegate(),
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [const Locale('ja', ''), const Locale('en', '')],
      localeResolutionCallback: (locale, supportedLocales) => _localeCallback(locale, supportedLocales),
      builder: (context, child) {
        return child;
      },
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        MainScreen.routeName: (context) => MainScreen(),
        GenreScreen.routeName: (context) => GenreScreen(),
        DetailMovieScreen.routeName: (context) => DetailMovieScreen(),
        FavoriteScreen.routeName: (context) => FavoriteScreen(),
      },
    );
  }

  Locale _localeCallback(Locale locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.first;
    }
    // Check if the current device locale is supported
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    // If the locale of the device is not supported, use the first one
    // from the list (en, in this case).
    return supportedLocales.first;
  }
}
