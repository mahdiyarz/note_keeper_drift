import 'dart:developer';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Note extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description => text().named('description')();
  IntColumn get priority => integer()();
  IntColumn get color => integer()();
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    log('open DB');
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [
  Note,
])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  //? get all the notes from db
  Future<List<NoteData>> getNoteList() async {
    log('fetching');
    return await select(note).get();
  }

  //? insert a note to db
  Future<int> insertNote(NoteCompanion noteCompanion) async {
    log('inserting');
    return await into(note).insert(noteCompanion);
  }

  //? delete a note from db
  Future<int> deleteNote(NoteData noteData) async {
    log('deleting');
    return await delete(note).delete(noteData);
  }
}
