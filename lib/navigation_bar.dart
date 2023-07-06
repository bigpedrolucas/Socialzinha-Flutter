// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'home_page.dart';

class CustomNavigationBar extends StatelessWidget {
  final int pageIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar(
      {super.key, required this.pageIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
          currentIndex: pageIndex,
          onTap: onTap,
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
          ]),
    );
  }
}
