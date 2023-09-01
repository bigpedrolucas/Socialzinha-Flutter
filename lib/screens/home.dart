// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/event_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.orangePrimary,
      extendBody: true,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        label: Text("Evento", style: TextStyle(color: AppColors.orangePrimary)),
        icon: Icon(Icons.add, color: AppColors.orangePrimary),
        onPressed: () {
          Navigator.pushNamed(context, '/event-form');
        },
      ),
      body: EventList(),
    ));
  }
}
