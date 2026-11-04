// Automatic FlutterFlow imports
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

Future<bool> checkRfidTagExists(
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
      print('Check Error: Failed to connect to MySQL database.');
      return false;
    }

    // 2. Query to check if TAG_ID exists
    final checkResult = await mysqlConn.execute(
      'SELECT id FROM AN_RFID WHERE TAG_ID = :tagId',
      {'tagId': tagId},
    );

    // Returns true if the tag exists, false if it does not
    return checkResult.rows.isNotEmpty;
  } catch (e) {
    print('Check Tag Error: $e');
    return false;
  } finally {
    // 3. Clean up connection
    try {
      if (mysqlConn != null && mysqlConn.connected) {
        await mysqlConn.close();
      }
    } catch (_) {}
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
