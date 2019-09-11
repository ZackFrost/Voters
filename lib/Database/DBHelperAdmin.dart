
import 'dart:async';
import 'package:voters/model/Admin.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;


class DBHelperAdmin{


  static Database db_instance;
  final String table_Name = 'admin';

  Future<Database> get db async{

    if(db_instance == null){
      db_instance = await initDB();
    }
    return db_instance;
  }

  //Creates db

  initDB() async {

    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    
    String path = join(documentsDirectory.path,'admin.db');
    
    var db = await openDatabase(path,version: 1, onCreate: createDB);

    return db;
  }
  

  void  createDB(Database db, int version) async {
    //Create Table
    await db.execute(
      'CREATE TABLE $table_Name(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, number TEXT, password TEXT)');
  }


  void addNewContact(Admin contact) async{

    var db_connection = await db;
    await db_connection.transaction((transaction) async{
      return await transaction.insert(table_Name, contact.toMapAdmin());
    });
  }

  Future<List<Map>> adminLogin(String number, String password) async {
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

//  // CRUD FUCNTIONS
//
//  //GET List of CONTACTS
//
//  Future<List<Admin>> getContacts() async{
//
//    var db_connection = await db;
//
//    List<Map> list = await db_connection.rawQuery('SELECT * FROM $table_Name');
//    List<Admin> contacts = new List();
//
//    for(int i = 0; i<list.length;i++)
//    {
//      Admin contact =  Admin.fromMap(list[i]);
//      contacts.add(contact);
//    }
//
//    return contacts;
//  }
//
//
//  //Insert New Contact


//
//  //edit Contact
//
//  void editContact(Admin contact) async{
//    var db_connection = await db;
//      await db_connection.transaction((transaction) async{
//        return await transaction.rawQuery(query);
//      });
//    }
//
//  //Delete Contact
//
//  void deleteContact(Admin contact) async{
//    var db_connection = await db;
//    String query = 'DELETE FROM $table_Name WHERE id=${contact.rid}';
//    await db_connection.transaction((transaction) async{
//      return await transaction.rawQuery(query);
//    });
//  }
//  }

  }
