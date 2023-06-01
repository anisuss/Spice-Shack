import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

import '../model/cart_model.dart';

class DBHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return null;
  }

  initDatabase() async {




    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cartData.db');
    var db = await openDatabase(path, version: 3, onCreate: _onCreate,onUpgrade: _onUpgrade);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE cartData(id , productId VARCHAR UNIQUE, productName TEXT, initialPrice DOUBLE, productPrice DOUBLE, quantity INTEGER, image TEXT,varData TEXT)');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE cartData ADD COLUMN newCol TEXT;");
    }}
  Future<Cart> insert(Cart cart) async {
    var dbClient = await database;
    //,conflictAlgorithm: ConflictAlgorithm.replace
    await dbClient!.insert('cartData', cart.toMap());
    return cart;
  }

  Future<List<Cart>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient!.query('cartData');
    return queryResult.map((result) => Cart.fromMap(result)).toList();
  }

  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete('cartData', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!.update('cartData', cart.quantityMap(),
        where: "productId = ?", whereArgs: [cart.productId]);
  }

  Future<List<Cart>> getCartId(int id) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryIdResult =
        await dbClient!.query('cartData', where: 'id = ?', whereArgs: [id]);
    return queryIdResult.map((e) => Cart.fromMap(e)).toList();
  }


  Future<void> dropTableIfExistsThenReCreate() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cartData.db');
    Database db = await openDatabase(path,onCreate: _onCreate);

    await db.execute("DROP TABLE IF EXISTS cartData");
    await db.execute('CREATE TABLE cartData(id , productId VARCHAR UNIQUE, productName TEXT, initialPrice DOUBLE, productPrice DOUBLE, quantity INTEGER, image TEXT,varData TEXT)');

  }

}
