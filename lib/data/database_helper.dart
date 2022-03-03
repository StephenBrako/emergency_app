import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:ghana/data/note.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';
  String coldob = 'dob';

  String colghcardsurname = 'ghcardsurname';
  String colghcardfirstname = 'ghcardfirstname';
  String colghcardpreviousname = 'ghcardpreviousname';
  String colghcardnationality = 'ghcardnationality';
  String colghcardsex = 'ghcardsex';
  String colghcarddateofbirth = 'ghcarddateofbirth';
  String colghcardplaceofissuance = 'ghcardplaceofissuance';
  String colghcardid = 'ghcardid';
  String colghcardheight = 'ghcardheight';
  String colghcarddateofissuance = 'ghcarddateofissuance';
  String colghcarddateofexpiry = 'ghcarddateofexpiry';
  String colghcarddocumentnumber = 'ghcarddocumentnumber';

  String colnhisname = 'nhisname';
  String colnhissex = 'nhissex';
  String colnhisdateofbirth = 'nhisdateofbirth';
  String colnhisid = 'nhisid';
  String colnhisdateofissuance = 'nhisdateofissuance';
  String colnhisdateofexpiry = 'nhisdateofexpiry';

  String collicencename = 'licencename';
  String collicencenationalid = 'licencenationalid';
  String collicenceprocessingcenter = 'licenceprocessingcenter';
  String collicencenationality = 'licencenationality';
  String collicenceclass = 'licenceclass';
  String collicencedateofbirth = 'licencedateofbirth';
  String coldateoffirstlicence = 'dateoffirstlicence';
  String collicencepin = 'licencepin';
  String collicencedateofissue = 'licencedateofissue';
  String collicencedateofexpiry = 'licencedateofexpiry';
  String collicencecertificatedate = 'licencecertificatedate';
  String colcertificateofcompetence = 'certificateofcompetence';

  String colsnnitname = 'snnitname';
  String colsnnitgender = 'snnitgender';
  String colsnnitdateofbirth = 'snnitdateofbirth';
  String colsnnitid = 'snnitid';

  String colvoteridsurname = 'voteridsurname';
  String colvoteridothername = 'voteridothername';
  String colvoteridsex = 'voteridsex';
  String colvoteriddateofbirth = 'voteriddateofbirth';
  String colvoteridpollingstationcode = 'voteridpollingstationcode';
  String colvoteriddateofregistration = 'voteriddateofregistration';
  String colvoteridnumber = 'voteridnumber';

  String colghcardpicture = 'ghcardpicture';
  String colnhispicture = 'nhispicture';
  String colsnnitpicture = 'snnitpicture';
  String collicencepicture = 'licencepicture';
  String colvoteridpicture = 'voteridpicture';
  

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper;
  }

  Future<Database> get database async {

    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    //Get path of the directory for android and iOS.

    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'cards.db');

    //open/create database at a given path
    var cardDatabase = await openDatabase(path, version: 1, onCreate: _createDb);

    return cardDatabase;

  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colghcardsurname TEXT, '
        '$colghcardfirstname TEXT, '
        '$colghcardpreviousname TEXT, '
        '$colghcardnationality TEXT, '
        '$colghcardsex TEXT, '
        '$colghcarddateofbirth TEXT, '
        '$colghcardplaceofissuance TEXT, '
        '$colghcardid TEXT, '
        '$colghcardheight TEXT, '
        '$colghcarddateofissuance TEXT, '
        '$colghcarddateofexpiry TEXT, '
        '$colghcarddocumentnumber TEXT, '

        '$colnhisname TEXT, '
        '$colnhissex TEXT, '
        '$colnhisdateofbirth TEXT, '
        '$colnhisid TEXT, '
        '$colnhisdateofissuance TEXT, '
        '$colnhisdateofexpiry TEXT, '

        '$collicencename TEXT, '
        '$collicencenationalid TEXT, '
        '$collicenceprocessingcenter TEXT, '
        '$collicencenationality TEXT, '
        '$collicenceclass TEXT, '
        '$collicencedateofbirth TEXT, '
        '$coldateoffirstlicence TEXT, '
        '$collicencepin TEXT, '
        '$collicencedateofissue TEXT, '
        '$collicencedateofexpiry TEXT, '
        '$collicencecertificatedate TEXT, '
        '$colcertificateofcompetence TEXT, '

        '$colsnnitname TEXT, '
        '$colsnnitgender TEXT, '
        '$colsnnitdateofbirth TEXT, '
        '$colsnnitid TEXT, '

        '$colvoteridsurname TEXT, '
        '$colvoteridothername TEXT, '
        '$colvoteridsex TEXT, '
        '$colvoteriddateofbirth TEXT, '
        '$colvoteridpollingstationcode TEXT, '
        '$colvoteriddateofregistration TEXT, '
        '$colvoteridnumber TEXT, '
        '$colghcardpicture TEXT, '
        '$colvoteridpicture TEXT, '
        '$colsnnitpicture TEXT, '
        '$colnhispicture TEXT, '
        '$collicencepicture TEXT, '

        '$coldob TEXT, '
        '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }
  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    var db = await this.database;
    var result = await db.update(noteTable, note.toMap(), where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {

    var noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<Note> noteList = List<Note>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }

}













