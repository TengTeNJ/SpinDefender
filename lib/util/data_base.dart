import 'package:spin_defender/models/training_time_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../constants.dart';
import 'package:shared_preferences/shared_preferences.dart';




class DataBaseHelper {
  static final DataBaseHelper _instance = DataBaseHelper._internal();

  factory DataBaseHelper() {
    return _instance;
  }

  DataBaseHelper._internal();
  Database? _database;
  // Database? _videoDatabase;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), kDataBaseTableName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db,int version) async{
    await db.execute('''
       CREATE TABLE ${kDataBaseTableName} (
          id INTERGER PRIMARYKEY,
          pickupBallNumber TEXT,
          time TEXT
       )
     ''');

    await db.execute('''
       CREATE TABLE ${kDataBaseTrainingTimeTableName} (
          id INTERGER PRIMARYKEY,
          trainingTime TEXT,
          time TEXT
       )
     ''');
  }

  Future<int> insertData(String table,TrainingTimeModel data) async {
    Database db = await database;
    return await db.insert(table, data.toJson());
  }

  Future<List<TrainingTimeModel>> getData(String table) async {
    Database db = await database;
    final _datas  = await db.rawQuery('SELECT * FROM ${table}');
    List<TrainingTimeModel> array = [];
    _datas.asMap().forEach((index,element){
      TrainingTimeModel model = TrainingTimeModel.modelFromJson(element);
      array.add(model);
    });
    return array;
  }


  Future<int> updateData( String table, Map<String, dynamic> data, String time) async {
    Database db = await database;
    return await db.update(table, data,where: 'time = ?', whereArgs: [time]);
  }

  Future<void> saveData(int useTime) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('useTime', useTime);
  }

  Future<void> saveUserInfoData(String useInfo) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('useInfo', useInfo);
  }

}