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
import 'package:mysql_client/mysql_client.dart';

Future<String?> getRfidDescription(
  String host,
  int port,
  String dbName,
  String user,
  String password,
  String tagId,
) async {
  MySQLConnection? mysqlConn;

  try {
    // 1. Establish connection to remote MySQL server
    mysqlConn = await MySQLConnection.createConnection(
      host: host,
      port: port,
      userName: user,
      password: password,
      databaseName: dbName,
      secure: false,
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
      return null;
    }

    // 2. Query description column for the specified TAG_ID
    final result = await mysqlConn.execute(
      'SELECT `description` FROM AN_RFID WHERE TAG_ID = :tagId',
      {'tagId': tagId},
    );

    // 3. Return description string if found, otherwise return null
    if (result.rows.isNotEmpty) {
      final rowData = result.rows.first.assoc();
      final description = rowData['description'];
      print(
          'Fetch Success: Retrieved description "$description" for TAG_ID "$tagId".');
      return description;
    } else {
      print('Fetch Notice: TAG_ID "$tagId" not found in AN_RFID.');
      return null;
    }
  } catch (e) {
    print('Get Description Error: $e');
    return null;
  } finally {
    // 4. Safe connection cleanup
    try {
      if (mysqlConn != null && mysqlConn.connected) {
        await mysqlConn.close();
      }
    } catch (_) {}
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
