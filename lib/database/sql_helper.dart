import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute(
      """
      CREATE TABLE usuario(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome VARCHAR(50),
        avatarUrl VARCHAR(50)
      )
      """,
    );
    await database.execute(
      """
      CREATE TABLE evento(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        titulo VARCHAR(150) NOT NULL,
        local VARCHAR(150) NOT NULL,
        dataHora DATETIME
      )
    """,
    );
    await database.execute(
      """
      CREATE TABLE tarefa(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        evento INTEGER,
        status INTEGER,
        titulo VARCHAR(150) NOT NULL,
        descricao VARCHAR(255) NOT NULL,
        FOREIGN KEY (evento) REFERENCES evento(id),
        FOREIGN KEY (status) REFERENCES status(id)
      )
      """,
    );
    await database.execute(
      """
      CREATE TABLE usuarioTarefa(
        usuario INTEGER,
        tarefa INTEGER,
        FOREIGN KEY (usuario) REFERENCES usuario(id),
        FOREIGN KEY (tarefa) REFERENCES tarefa(id)
      )
      """,
    );
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'database.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await SQLHelper.db();
    return db.query(table, orderBy: "dataHora");
  }

  static Future<List<Map<String, dynamic>>> getItem(
      String table, int id) async {
    final db = await SQLHelper.db();
    return db.query(table, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> createItem(String table, Map<String, dynamic> data) async {
    final db = await SQLHelper.db();
    final id = await db.insert(table, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> updateItem(
      String table, int id, Map<String, dynamic> data) async {
    final db = await SQLHelper.db();
    return db.update(table, data, where: "id = ?", whereArgs: [id]);
  }

  static Future<void> deleteItem(String table, int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(table, where: "id = ?", whereArgs: [id]);
    } catch (error) {
      debugPrint("Erro ao deletar item: $error");
    }
  }
}
