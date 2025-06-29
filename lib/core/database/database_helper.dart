import 'app_database.dart';

class DatabaseHelper {
  static AppDatabase? _database;

  static Future<AppDatabase> getDatabase() async {
    _database ??=
        await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    return _database!;
  }
}
