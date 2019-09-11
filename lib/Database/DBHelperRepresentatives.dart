
import 'dart:async';
import 'package:voters/model/Admin.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;


class DBHelper {


  static Database db_instance;
  final String table_Name = 'users';

  Future<Database> get db async {
    if (db_instance == null) {
      db_instance = await initDB();
    }
    return db_instance;
  }

  //Creates db

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentsDirectory.path, 'users.db');

    var db = await openDatabase(path, version: 1, onCreate: createDB);

    return db;
  }


  void createDB(Database db, int version) async {
    //Create Table
    await db.execute(
        'CREATE TABLE $table_Name(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, number TEXT, password TEXT, adminNumber TEXT)');
  }

  // CRUD FUCNTIONS

  //GET List of CONTACTS

  Future<List<Admin>> getContacts(String number) async {
    var db_connection = await db;

    List<Map> list = await db_connection.query(table_Name,where: 'adminNumber =?',whereArgs: [number]);
    List<Admin> contacts = new List();

    for (int i = 0; i < list.length; i++) {
      Admin contact = Admin.fromMap(list[i]);
      contacts.add(contact);
    }

    return contacts;
  }


  //Insert New Contact

  void addNewContact(Admin contact) async {
    var db_connection = await db;

    await db_connection.transaction((transaction) async {
      return await transaction.insert(table_Name, contact.toMap());
    });
  }


  //edit Contact

  void editContact(Admin contact) async {
    var db_connection = await db;

    await db_connection.transaction((transaction) async {
      return await transaction.update(table_Name,contact.toMap(),where: 'id =?' ,whereArgs: [contact.id] );
    });
  }

  //Delete Contact

  void deleteContact(int id) async {
    var db_connection = await db;
    await db_connection.transaction((transaction) async {
      return await transaction.delete(table_Name, where: 'id =?' ,whereArgs: [id] );
    });
  }


  Future<List<Map>> repLogin(String number, String password) async {
    String colPassword = 'password';
    String colNumber = 'number';
    String colName = 'name';

    var db_connection = await db;
    var result = await db_connection.query(table_Name,
        columns: [colName, colNumber, colPassword],
        where: '$colNumber =? AND $colPassword =?',
        whereArgs: [number, password]);

    if (result.length > 0) {
      return result;
    }
    return null;
  }



}