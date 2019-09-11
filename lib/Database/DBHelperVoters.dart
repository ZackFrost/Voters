
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:voters/model/Voter.dart';


//voters Database

class DBHelper1{



  static Database db_instance;
  final String table_Name = 'voters';

  Future<Database> get db async{

    if(db_instance == null){
      db_instance = await initDB();
    }
    return db_instance;
  }

  //Creates db

  initDB() async {

    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    
    String path = join(documentsDirectory.path,'rep.db');
    
    var db = await openDatabase(path,version: 1, onCreate: createDB);

    return db;
  }
  

  void  createDB(Database db, int version) async {
    //Create Table
    await db.execute(
      'CREATE TABLE $table_Name(id INTEGER PRIMARY KEY AUTOINCREMENT,'
          'name TEXT,'
          'mobilenumber TEXT,'
          'age INTEGER,'
          'address TEXT,'
          'booth INTEGER,'
          'village TEXT,'
          'mandal TEXT,'
          'district TEXT,'
          'constituency TEXT,'
          'repnumber TEXT'
          ')');
  }

  // CRUD FUCNTIONS

  //GET List of CONTACTS

  Future<List<Voter>> getContacts(String number) async{

    var db_connection = await db;

    List<Map> list = await db_connection.query(table_Name,where: 'repnumber =?',whereArgs: [number]);
    List<Voter> contacts = new List();

    for(int i = 0; i < list.length;i++)
    {
      Voter contact = Voter.fromMap(list[i]);
      contacts.add(contact);
    }

    return contacts;
  }


  //Insert New Contact

  void addNewContact(Voter contact) async{

    var db_connection = await db;
    await db_connection.transaction((transaction) async{
      return await transaction.insert(table_Name,contact.toMap(),);
    });
  }


  //edit Contact

  void editContact(Voter contact) async{
    var db_connection = await db;
      await db_connection.transaction((transaction) async{
        return await transaction.update(table_Name, contact.toMap(),where: 'repnumber =?',whereArgs: [contact.repnumber] );
      });
    }

  //Delete Contact

  void deleteContact(int id) async{
    var db_connection = await db;
    await db_connection.transaction((transaction) async{
      return await transaction.delete(table_Name,where: 'id =?',whereArgs: [id]);
    });
  }

  //Check Username and Password

// Future<List<Map>> check(String number, String password) async{
//
//    String colPassword = 'password';
//    String colNumber = 'number';
//    String colName = 'name';
//
//    var db_connection = await db;
//     var result = await db_connection.query(table_Name,
//            columns: [colName,colNumber,colPassword],
//            where: '$colNumber =? AND $colPassword =?',
//            whereArgs: [number,password]);
//
////    List<Map> resultPass = await db_connection.query(table_Name,
////        columns: [colPassword],
////        where: '$colPassword =? && $col',
////        whereArgs: [password]);
//
//    if(result.length> 0){
//      return result;
//    }
//    return null;
//
//
//    //    var res = await db_connection.transaction((transaction) async{
////      list = await transaction.query(table_Name,columns: ['number','password']  ,
////           where: 'number=? AND password =?',
////           whereArgs:[contact.rnumber,contact.rpassword]);
////
////    });


  }