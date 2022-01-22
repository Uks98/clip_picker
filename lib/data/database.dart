import 'package:clip_picker/data/pick_class.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = "pick.db";
  static final _databaseVersion = 2;
  static final pickTable = "pick";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate,
        onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $pickTable (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name String,
        memo String,
        time INTEGER DEFAULT 0,
        date INTEGER DEFAULT 0,
        studyTime INTEGER DEFAULT 0,
        studyType INTEGER DEFAULT 0,
        hardStudy INTEGER DEFAULT 0,
        image String,
        color INTEGER DEFAULT 0
      )
      ''');
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {}

  // 투두 입력, 수정, 불러오기
  Future<int> insertPick(Pick pick) async {
    Database db = await instance.database;

    if(pick.id == null){
      //생성
      final _map = pick.toMap();
      return await db.insert(pickTable, _map);
    }else{
      //변경
      final _map = pick.toMap();
      return await db.update(pickTable, _map, where: "id = ? ", whereArgs: [pick.id]);
    }
  }

  Future<List<Pick>> queryPickByDate(int date) async {
    Database db = await instance.database;
    List<Pick> picks = [];

    final query = await db.query(pickTable, where: "date = ?", whereArgs: [date]);

    for(final r in query){
      picks.add(Pick.fromDB(r));
    }
    return picks;
  }

  Future<List<Pick>> queryAllPick() async {
    Database db = await instance.database;
    List<Pick> picks = [];

    final query = await db.query(pickTable);

    for(final r in query){
      picks.add(Pick.fromDB(r));
    }
    return picks;
  }

}