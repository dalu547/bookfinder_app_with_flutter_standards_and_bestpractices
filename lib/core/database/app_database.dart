import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:bookfinder/data/datasources/local/book_details_dao.dart';
import 'package:bookfinder/domain/entities/book_details_entity.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [BookDetailEntity])
abstract class AppDatabase extends FloorDatabase {
  BookDetailsDao get booDetailsDao;
}
