import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


import 'cartCategroiesModel.dart';


class DBHelperStatic {

  static Database? _db ;

  Future<Database?> get db async {
    if(_db != null){
      return _db!;
    }

    _db = await initDatabase();
    return null;
  }

  initDatabase()async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory() ;
    String path = join(documentDirectory.path , 'cartData.db');
    var db = await openDatabase(path , version: 3 , onCreate: _onCreate,onUpgrade: _onUpgrade);
    return db ;
  }

  _onCreate (Database db , int version )async{
     db.execute('CREATE TABLE cartData (id, productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , quantity INTEGER, image TEXT,varData TEXT, )');

  }
  // UPGRADE DATABASE TABLES
  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE cartData ADD COLUMN newCol TEXT;");
    }}

  Future<ProductModel> insert(ProductModel cart)async{
    if (kDebugMode) {
      print(cart.toMap());
    }
    var dbClient = await db ;
    await dbClient!.insert('cartData', cart.toMap());
    return cart ;
  }

  Future<List<ProductModel>> getCartList()async{
    var dbClient = await db;
    final List<Map<String , Object?>> queryResult =  await dbClient!.query('cartData');
    return queryResult.map((e) => ProductModel.fromMap(e)).toList();

  }

   clearCart() async {
    var dbClient = await db ;
    await dbClient?.execute("DROP TABLE IF EXISTS cartData");
  }



  Future<int> delete(int id)async{
    var dbClient = await db ;
    return await dbClient!.delete(
        'cartData',
        where: 'id = ?',
        whereArgs: [id]
    );
  }

  Future<int> updateQuantity(ProductModel cart)async{
    var dbClient = await db ;
    return dbClient!.update(
        'cartData',
        cart.toMap(),
        where: 'id = ?',
        whereArgs: [cart.id]
    );
  }
  Future<void> dropTableIfExistsThenReCreate() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cartData.db');
    Database db = await openDatabase(path,onCreate: _onCreate);

    await db.execute("DROP TABLE IF EXISTS cartData");
    await db.execute('CREATE TABLE cartData(id, productId VARCHAR UNIQUE,productName TEXT,initialPrice INTEGER, productPrice INTEGER , quantity INTEGER, image TEXT,varData TEXT, )');

  }

}