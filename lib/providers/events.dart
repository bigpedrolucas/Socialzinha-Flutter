import 'package:flutter/material.dart';

import '../database/sql_helper.dart';

class Events with ChangeNotifier {
  List<Map<String, dynamic>> _events = [];

  Events() {
    _refreshEvents();
  }

  Future<void> _refreshEvents() async {
    final data = await SQLHelper.getAll('evento');
    _events = data;
    notifyListeners();
  }

  int get count {
    return _events.length;
  }

  Map<String, dynamic> byIndex(int index) {
    return _events[index];
  }

  Future<void> addItem(String event, Map<String, Object?> data) async {
    await SQLHelper.createItem(event, data);
    _refreshEvents();
  }

  Future<void> deleteItem(String table, int id) async {
    await SQLHelper.deleteItem(table, id);
    _refreshEvents();
  }
}
