import 'package:get/get.dart';
import 'package:my_weight/db_weight/weight_entity.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBWeight extends GetxService {
  late Database dbBase;

  Future<DBWeight> init() async {
    await createWeightDB();
    return this;
  }

  createWeightDB() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'weight.db');

    dbBase = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await createWeightTable(db);
      await initWeight(db);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('initial', 70);
      await prefs.setDouble('target', 40);
    });
  }

  createWeightTable(Database db) async {
    await db.execute(
        'CREATE TABLE IF NOT EXISTS weight (id INTEGER PRIMARY KEY, createdTime TEXT, type INTEGER, weight TEXT, fastingTime TEXT)');
  }

  initWeight(Database db) async {
    final id = await db.insert('weight', {
      'createdTime': DateTime.now().toIso8601String(),
      'type': 0,
      'weight': '70',
      'fastingTime': DateTime.now().toIso8601String(),
    });
    return id;
  }

  insertWeight(WeightEntity entity) async {
    final id = await dbBase.insert('weight', {
      'createdTime': entity.createdTime.toIso8601String(),
      'type': entity.type,
      'weight': entity.weight,
      'fastingTime': entity.fastingTime.toIso8601String(),
    });
    return id;
  }

  updateWeight(WeightEntity entity) async {
    await dbBase.update('weight', {
      'createdTime': entity.createdTime.toIso8601String(),
      'weight': entity.weight,
      'fastingTime': entity.fastingTime.toIso8601String(),
    }, where: 'id = ?', whereArgs: [entity.id]);
  }

  cleanWeightData() async {
    await dbBase.delete('weight');
  }

  Future<List<WeightEntity>> getWeightAllData() async {
    var result = await dbBase.query('weight', orderBy: 'createdTime ASC');
    return result.map((e) => WeightEntity.fromJson(e)).toList();
  }

  Future<List<WeightEntity>> getLast7DaysWeights() async {

    DateTime now = DateTime.now().toLocal();
    DateTime todayStart = DateTime(now.year, now.month, now.day);
    DateTime sevenDaysAgoStart = todayStart.subtract(const Duration(days:6));
    int sevenDaysAgoMillis = sevenDaysAgoStart.millisecondsSinceEpoch;
    
    final List<Map<String, dynamic>> maps = await dbBase.query(
      'weight',
      where: 'createdTime >= ?',
      whereArgs: [sevenDaysAgoMillis],
      orderBy: 'createdTime ASC',
    );
    return maps.map((map) => WeightEntity(
      id: map['id'],
      createdTime: DateTime.parse(map['createdTime']),
      type: map['type'],
      weight: map['weight'],
      fastingTime: DateTime.parse(map['fastingTime']),
    )).toList();
  }
}
