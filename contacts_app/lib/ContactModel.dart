import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'Contact.dart';

class ContactModel {
  static final _databaseName = "contactDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'contacts';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnDateAdded = 'dateadded';
  static final columnPhone = 'phone';
  static final userAvatarUrl = 'userAvatarUrl';

  ContactModel._privateConstructor();
  static final ContactModel instance = ContactModel._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    databaseFactory.deleteDatabase(path);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName TEXT NOT NULL,
            $columnPhone TEXT NOT NULL,
            $columnDateAdded TEXT NOT NULL,
            $userAvatarUrl TEXT NOT NULL
          )
          ''');
  }

  Future<void> insertContact(Contact contact) async {
    Database db = await instance.database;

    await db.insert(
      'contacts',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Contact>> getAllContacts() async {
    Database db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query('contacts');

    return List.generate(maps.length, (i) {
      return Contact(
        maps[i]['id'],
        maps[i]['name'],
        maps[i]['dateadded'],
        maps[i]['phone'],
        maps[i]['userAvatarUrl'],
      );
    });
  }

  Future<void> deleteAllContacts() async {
    Database db = await instance.database;

    await db.delete(
      'contacts',
    );
  }

  Future<void> deleteContactById(int id) async {
    Database db = await instance.database;

    await db.delete(
      'contacts',
      where: "id = ?",
      whereArgs: [id],
    );
  }
} //end of class
