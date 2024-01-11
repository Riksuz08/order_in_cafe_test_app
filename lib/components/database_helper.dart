import 'dart:async';
import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_app_cafe/models/cart.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._internal();
    }
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'CART.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE carts (
            table_name TEXT PRIMARY KEY,
            cart_items TEXT
          )
        ''');
      },
    );
  }

  Future<void> saveCarts(Map<String, List<Cart>> carts) async {
    final Database db = await database;
    await db.transaction((txn) async {
      for (var entry in carts.entries) {
        await txn.rawInsert('''
          INSERT OR REPLACE INTO carts(table_name, cart_items)
          VALUES(?, ?)
        ''', [entry.key, jsonEncode(entry.value)]);
      }
    });
  }

  Future<Map<String, List<Cart>>> loadCarts() async {
    final Database db = await database;
    final List<Map<String, dynamic>> result = await db.query('carts');
    
    return Map.fromEntries(result.map((row) {
      return MapEntry(
        row['table_name'] as String,
        (jsonDecode(row['cart_items'] as String) as List<dynamic>)
            .map((item) => Cart.fromJson(item))
            .toList(),
      );
    }));
  }
}
