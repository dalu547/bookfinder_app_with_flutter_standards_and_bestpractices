// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BookDetailsDao? _bookDetailsDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `tblBookDetails` (`olid` TEXT NOT NULL, `publisher` TEXT NOT NULL, `numberOfPages` INTEGER NOT NULL, `publishDate` TEXT NOT NULL, PRIMARY KEY (`olid`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BookDetailsDao get bookDetailsDao {
    return _bookDetailsDaoInstance ??=
        _$BookDetailsDao(database, changeListener);
  }
}

class _$BookDetailsDao extends BookDetailsDao {
  _$BookDetailsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _bookDetailsTableInsertionAdapter = InsertionAdapter(
            database,
            'tblBookDetails',
            (BookDetailsTable item) => <String, Object?>{
                  'olid': item.olid,
                  'publisher': item.publisher,
                  'numberOfPages': item.numberOfPages,
                  'publishDate': item.publishDate
                }),
        _bookDetailsTableUpdateAdapter = UpdateAdapter(
            database,
            'tblBookDetails',
            ['olid'],
            (BookDetailsTable item) => <String, Object?>{
                  'olid': item.olid,
                  'publisher': item.publisher,
                  'numberOfPages': item.numberOfPages,
                  'publishDate': item.publishDate
                }),
        _bookDetailsTableDeletionAdapter = DeletionAdapter(
            database,
            'tblBookDetails',
            ['olid'],
            (BookDetailsTable item) => <String, Object?>{
                  'olid': item.olid,
                  'publisher': item.publisher,
                  'numberOfPages': item.numberOfPages,
                  'publishDate': item.publishDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BookDetailsTable> _bookDetailsTableInsertionAdapter;

  final UpdateAdapter<BookDetailsTable> _bookDetailsTableUpdateAdapter;

  final DeletionAdapter<BookDetailsTable> _bookDetailsTableDeletionAdapter;

  @override
  Future<List<BookDetailsTable>> getAllBookDetails() async {
    return _queryAdapter.queryList('SELECT * FROM tblBookDetails',
        mapper: (Map<String, Object?> row) => BookDetailsTable(
            olid: row['olid'] as String,
            publisher: row['publisher'] as String,
            numberOfPages: row['numberOfPages'] as int,
            publishDate: row['publishDate'] as String));
  }

  @override
  Future<BookDetailsTable?> getBookDetailsById(String olid) async {
    return _queryAdapter.query('SELECT * FROM tblBookDetails WHERE olid = ?1',
        mapper: (Map<String, Object?> row) => BookDetailsTable(
            olid: row['olid'] as String,
            publisher: row['publisher'] as String,
            numberOfPages: row['numberOfPages'] as int,
            publishDate: row['publishDate'] as String),
        arguments: [olid]);
  }

  @override
  Future<int> insertBookDetails(BookDetailsTable bookDetails) {
    return _bookDetailsTableInsertionAdapter.insertAndReturnId(
        bookDetails, OnConflictStrategy.replace);
  }

  @override
  Future<int> updateBook(BookDetailsTable bookDetails) {
    return _bookDetailsTableUpdateAdapter.updateAndReturnChangedRows(
        bookDetails, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteBook(BookDetailsTable bookDetails) {
    return _bookDetailsTableDeletionAdapter
        .deleteAndReturnChangedRows(bookDetails);
  }
}
