// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'event_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      initialRoute: '/',
      routes: {'/event': (context) => EventDetailPage()},
    );
  }
}
