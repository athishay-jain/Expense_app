import 'dart:io';

import 'package:expance_app/Local/Models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../Models/expense_model.dart';

class Dbhelper {
  Dbhelper._();

  static Dbhelper GetIntances() => Dbhelper._();
  Database? mdb;

  /// table names
  static const String Table_Expence = "expense";
  static const String Table_user = "user";

  /// user table column

  static const String user_id = "id";
  static const String user_name = "name";
  static const String user_email = "email";
  static const String user_password = "password";
  static const String user_mobile = "mobile";

  /// expance table column

  static const String expence_id = "expense_id";
  static const String expance_title = "title";
  static const String expance_description = "description";
  static const String expance_amount = "amount";
  static const String expance_balance = "balance";
  static const String expance_category = "category";
  static const String expance_date = "date";
  static const String expence_type = "type";

  GetDb() async {
    if (mdb == null) {
      mdb = await OpenDb();
      return mdb;
    } else {
      return mdb!;
    }
  }

  Future<Database> OpenDb() async {
    Directory appdir = await getApplicationDocumentsDirectory();
    String dbpath = join(appdir.path, "expence.db");
    return openDatabase(
      dbpath,
      version: 1,
      onCreate: (db, version) {
        /// create user table
        db.execute(
            "create table $Table_user($user_id integer primary key autoincrement,$user_name text,$user_email text,$user_password text,$user_mobile text)");

        /// create expence table
        /*  db.execute(
            "create table expense($expence_id integer primary key autoincrement,$user_id integer,$expance_title text,$expance_description text,$expance_amount text,$expance_balance real,$expance_category integer,$expance_date text,$expence_type integer)");*/

        db.execute(
            "create table $Table_Expence($expence_id integer primary key autoincrement,$user_id integer,$expance_title text,$expance_description text,$expance_amount real,$expance_balance real,$expance_category integer,$expance_date text,$expence_type integer)");
      }, );
  }

  ///events
  ///create user

  Future<bool> createUser({required UserModel user})async{
    var db = await GetDb();
 int rowseffected = await db.insert(Table_user, user.tomap());
 return rowseffected>0;

  }
///check user if already exist

Future<bool> checkIfUserExist({required String email})async{
    Database db= await GetDb();
    List<Map<String,dynamic>> mdata = await db.query(Table_user , where: "$user_email = ?", whereArgs: [email]);
   return mdata.isNotEmpty;
}

  ///authenticate
Future<bool>authenticate({required String email , required String password})async{
    Database db = await GetDb();
 List<Map<String,dynamic>>mdata= await   db.query(Table_user,where: "$user_email = ? AND $user_password = ?" , whereArgs: [email,password]);

 if(mdata.isNotEmpty){
   SharedPreferences Prefs = await SharedPreferences.getInstance();
   Prefs.setInt("user",mdata[0][Dbhelper.user_id]);
   print("User Id From Profs is  : ${Prefs.getInt("user")}");
 }
 return mdata.isNotEmpty;
}



///addexpance

Future<bool>addExpense({required ExpenseModel newexpense})async{
    Database db = await GetDb();
    SharedPreferences Prefs = await SharedPreferences.getInstance();
   newexpense.user_id =  Prefs.getInt("user") ?? 0;
    int rowseffected = await db.insert(Table_Expence, newexpense.tomap());
    debugPrint("Checking the Last balance logic working or not and the balance is : ${newexpense.expance_balance}");

    return rowseffected>0;
}


///fethall exoance

Future<List<ExpenseModel>> fetchExpense()async{
    SharedPreferences Prefs = await SharedPreferences.getInstance();
    int userID = Prefs.getInt("user")!;
    Database db = await GetDb();
  List<Map<String , dynamic>> mData =await db.query(Table_Expence,where: "$user_id = ?", whereArgs: [userID]);
  List<ExpenseModel>expenses =[];
  for(Map<String , dynamic> eachExp in mData){
    expenses.add(ExpenseModel.frommap(eachExp));
  }
  return expenses;
}
///delete expance
///update expance
}
