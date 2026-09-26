
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'db_tables.dart';

part 'main_db.g.dart';


///provider for the db , used in any service that touch the local database
final dbProvider = Provider((ref){
  final db = AppDatabase();
  ref.onDispose(()=>db.close());
  return db;
});


@DriftDatabase(tables: [AdditionalUserDataDB])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) async => m.createAll(),
  );
 
}

QueryExecutor _openConnection(){
  return driftDatabase(name: 'app_local_db');
}