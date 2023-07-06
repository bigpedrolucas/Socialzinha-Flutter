// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:social_app/event_page.dart';
import 'account_page.dart';
import 'event_list_page.dart';
import 'navigation_bar.dart';

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
  int _pageIndex = 0;

  final List<Widget> _pages = [EventsListPage(), EventPage(), AccountPage()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            body: _pages[_pageIndex],
            bottomNavigationBar: CustomNavigationBar(
              pageIndex: _pageIndex,
              onTap: (index) {
                setState(() {
                  _pageIndex = index;
                });
              },
            )));
  }
}
