// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/event.dart';
import 'pages/home.dart';
import 'pages/event_form.dart';
import 'providers/events.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Events())],
      child: MaterialApp(
        home: HomePage(),
        initialRoute: '/',
        routes: {
          '/event': (context) => EventPage(),
          '/event-form': (context) => EventForm(),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('en', 'US'),
        ],
      ),
    );
  }
}
