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
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:mysql_client/mysql_client.dart';

Future<bool> updateSqliteProductsFromMysql(
  String host,
  int port,
  String dbName,
  String user,
  String password,
) async {
  MySQLConnection? mysqlConn;
  Database? sqliteDb;

  try {
    // 1. Establish connection to remote MySQL server
    mysqlConn = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: user,
      password: password,
      databaseName: dbName,
      secure: false, // Set to true if server enforces SSL
    );

    await mysqlConn.connect().timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        throw TimeoutException(
            'Connection timed out while connecting to MySQL.');
      },
    );

    if (!mysqlConn.connected) {
      print('Fetch Error: Failed to connect to MySQL database.');
      return false;
    }

    // 2. Fetch all products from remote MySQL database
    final results = await mysqlConn.execute(
      'SELECT id, name_description, Brand, part_number FROM Products',
    );

    // 3. Dynamically locate local SQLite database file
    final databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'rfiddb.db');

    final dbDir = Directory(databasesPath);
    if (await dbDir.exists()) {
      final files = dbDir.listSync();
      for (final file in files) {
        if (p.basename(file.path).toLowerCase() == 'rfiddb.db') {
          path = file.path;
          break;
        }
      }
    }

    sqliteDb = await openDatabase(path);

    // 4. Batch update / upsert products based on part_number
    final batch = sqliteDb.batch();

    for (final row in results.rows) {
      final data = row.assoc();

      final rowData = <String, dynamic>{
        'name_description': data['name_description'],
        'Brand': data['Brand'],
        'part_number': data['part_number'],
      };

      if (data.containsKey('id') && data['id'] != null) {
        rowData['id'] = data['id'];
      }

      // ConflictAlgorithm.replace automatically overwrites matching UNIQUE/PRIMARY columns (part_number)
      batch.insert(
        'Products',
        rowData,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }

    await batch.commit(noResult: true);
    print(
        'Products table updated successfully based on part_number (${results.rows.length} rows processed).');
    return true;
  } catch (e) {
    print('Update Error: Failed to pull products from MySQL: $e');
    return false;
  } finally {
    // 5. Clean up database connections safely
    try {
      await sqliteDb?.close();
    } catch (_) {}

    try {
      if (mysqlConn != null && mysqlConn.connected) {
        await mysqlConn.close();
      }
    } catch (_) {}
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
