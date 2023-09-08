import 'package:flutter/material.dart';
import 'package:social_app/models/event.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider with ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;

  Database? _database;

  static const userTable = 'user';
  static const eventTable = 'event';
  static const taskTable = 'task';
  static const userTaskTable = 'user_task';

  Future<Database> get database async {
    final dbDirectory = await getDatabasesPath();
    const dbName = 'database.db';
    final path = join(dbDirectory, dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );

    return _database!;
  }

  static Future<void> _createTables(Database db, int version) async {
    await db.transaction((txn) async {
      await txn.execute("""CREATE TABLE $userTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        name VARCHAR(50),
        avatarUrl VARCHAR(50)
      )""");
      await txn.execute("""CREATE TABLE $eventTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title VARCHAR(150) NOT NULL,
        local VARCHAR(150) NOT NULL,
        date DATETIME
      )""");
      await txn.execute("""CREATE TABLE $taskTable(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        event INTEGER,
        status INTEGER,
        title VARCHAR(150) NOT NULL,
        description VARCHAR(255) NOT NULL,
        FOREIGN KEY (event) REFERENCES event(id),
        FOREIGN KEY (status) REFERENCES status(id)
      )""");
      await txn.execute("""CREATE TABLE $userTaskTable(
        user INTEGER,
        task INTEGER,
        FOREIGN KEY (user) REFERENCES user(id),
        FOREIGN KEY (task) REFERENCES task(id)
      )""");
    });
  }

  Future<List<Event>> fetchEvents() async {
    final db = await database;
    return await db.transaction((txn) async {
      return await txn.query(eventTable).then((data) {
        // 'data' is our fetched value
        // convert it from "Map<String, object>" to "Map<String, dynamic>"
        final converted = List<Map<String, dynamic>>.from(data);
        // create a 'Event' from every 'map' in this 'converted'
        List<Event> nList = List.generate(
            converted.length, (index) => Event.fromString(converted[index]));
        // set the value of 'events' to 'nList'
        _events = nList;
        // return the '_events'
        return _events;
      });
    });
  }

  Future<void> addEvent(Event event) async {
    final db = await database;
    await db.transaction(
      (txn) async {
        await txn
            .insert(
          eventTable,
          event.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        )
            .then(
          (generatedId) {
            final file = Event(
                id: generatedId,
                title: event.title,
                local: event.local,
                date: event.date);
            _events.add(file);
            notifyListeners();
          },
        );
      },
    );
  }
}
