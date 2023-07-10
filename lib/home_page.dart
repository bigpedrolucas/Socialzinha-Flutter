// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'events_list_page.dart';

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
      extendBody: true,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        label: Text("Evento", style: TextStyle(color: orangePrimary)),
        icon: Icon(Icons.add, color: orangePrimary),
        onPressed: () {
          print("add pressed");
        },
      ),
      body: EventsListPage(),
      /*bottomNavigationBar: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(25),
                  topLeft: Radius.circular(25),
                ),
                child: BottomNavigationBar(
                    backgroundColor: Colors.white,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedFontSize: 6,
                    iconSize: 25,
                    currentIndex: _currentIndex,
                    onTap: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    items: <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.home,
                          color: grayPrimary,
                        ),
                        label: 'Página Inicial',
                      ),
                      BottomNavigationBarItem(
                          icon: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: orangePrimary, shape: BoxShape.circle),
                              padding: EdgeInsets.all(14),
                              child: Icon(Icons.add, color: Colors.white),
                            ),
                          ),
                          label: 'Novo Evento'),
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.person,
                          color: grayPrimary,
                        ),
                        label: 'Perfil',
                      ),
                    ]))*/
    ));
  }
}
