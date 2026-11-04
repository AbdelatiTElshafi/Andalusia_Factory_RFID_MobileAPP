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
import 'package:mysql1/mysql1.dart';

Future<dynamic> fetchSavedTagsFromMysql(
  String host,
  int port,
  String dbName,
  String user,
  String password,
) async {
  MySqlConnection? mysqlConn;

  List<String> tagsID = [];
  List<String> serials = [];
  List<String> name = [];
  List<String> partNumbers = [];

  try {
    final settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: dbName,
      timeout: const Duration(seconds: 15),
    );

    mysqlConn = await MySqlConnection.connect(settings);

    // Query saved_tags table
    final results = await mysqlConn.query(
      'SELECT name_description, serial_number, tag_id, part_number FROM saved_tags',
    );

    // Build independent string lists for each column
    for (var row in results) {
      tagsID.add(row['tag_id']?.toString() ?? '');
      serials.add(row['serial_number']?.toString() ?? '');
      name.add(row['name_description']?.toString() ?? '');
      partNumbers.add(row['part_number']?.toString() ?? '');
    }

    return {
      'tagsID': tagsID,
      'serials': serials,
      'name': name,
      'partNumbers': partNumbers,
    };
  } catch (e) {
    print('MySQL Fetch Error: $e');
    return {
      'tagsID': <String>[],
      'serials': <String>[],
      'name': <String>[],
      'partNumbers': <String>[],
    };
  } finally {
    await mysqlConn?.close();
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
