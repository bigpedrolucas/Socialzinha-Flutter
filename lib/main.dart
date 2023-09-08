// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:social_app/models/database_provider.dart';
import 'package:social_app/screens/event.dart';
import 'package:social_app/screens/event_form.dart';
import 'package:social_app/screens/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DatabaseProvider())
      ],
      child: MaterialApp(
        home: Home(),
        initialRoute: '/',
        routes: {
          '/event': (context) => EventPage(),
          '/event-form': (context) => EventForm(),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('en', 'US'),
        ],
      ),
    );
  }
}
