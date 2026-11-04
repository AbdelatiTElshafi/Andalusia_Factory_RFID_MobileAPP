// Automatic FlutterFlow imports
import '/flutter_flow/ff_builtin_enums.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

Future<bool> clearSqliteTables() async {
  Database? sqliteDb;

  try {
    // 1. Locate and open SQLite local database
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, 'RFIDDB.db');
    sqliteDb = await openDatabase(path);

    // 2. Clear tables while preserving Products catalog
    await sqliteDb.delete('inventory_items');
    await sqliteDb.delete('inventory_orders');
    await sqliteDb.delete('saved_tags');

    return true;
  } catch (e) {
    print('Error clearing SQLite database: $e');
    return false;
  } finally {
    // 3. Close database connection
    await sqliteDb?.close();
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
