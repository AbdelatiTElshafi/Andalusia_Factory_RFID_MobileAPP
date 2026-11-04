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

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<int> createInventoryOrder(String inventoryNo, String notes) async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'inventory.db');

  final db = await openDatabase(path);

  final id = await db.insert('inventory_orders', {
    'inventory_no': inventoryNo,
    'start_time': DateTime.now().toIso8601String(),
    'end_time': null,
    'status': 'OPEN',
    'total_scanned': 0,
    'notes': notes,
  });

  await db.close();
  return id;
}
