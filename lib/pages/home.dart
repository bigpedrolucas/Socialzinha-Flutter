// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'event_list.dart';

Color orangePrimary = const Color(0xFFFA8642);
Color grayPrimary = const Color(0xFF989898);
Color lightGray = const Color(0xFFE6E6E6);
Color graphitePrimary = const Color(0xFF3D2F2F);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: orangePrimary,
      extendBody: true,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        label: Text("Evento", style: TextStyle(color: orangePrimary)),
        icon: Icon(Icons.add, color: orangePrimary),
        onPressed: () {
          Navigator.pushNamed(context, '/event-form');
        },
      ),
      body: EventList(),
    ));
  }
}
