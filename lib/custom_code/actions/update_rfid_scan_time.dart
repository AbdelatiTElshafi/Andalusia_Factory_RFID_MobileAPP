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

Future<bool> updateRfidScanTime(
  String host,
  int port,
  String dbName,
  String user,
  String password,
  String tagId,
  String columnName,
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
      print('Update Error: Failed to connect to MySQL database.');
      return false;
    }

    // 2. Format current date & time as %Y-%m-%d %H:%M:%S
    final now = DateTime.now();
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final formattedTime =
        '${now.year}-${twoDigits(now.month)}-${twoDigits(now.day)} ${twoDigits(now.hour)}:${twoDigits(now.minute)}:${twoDigits(now.second)}';

    // 3. Dynamically update the specified column for the given TAG_ID
    // Backticks are added around columnName to safely support names starting with numbers (e.g., `1st_scan_time`)
    final query =
        'UPDATE AN_RFID SET `$columnName` = :formattedTime WHERE TAG_ID = :tagId';

    await mysqlConn.execute(
      query,
      {
        'formattedTime': formattedTime,
        'tagId': tagId,
      },
    );

    print(
        'Update Success: Column "$columnName" updated to $formattedTime for TAG_ID "$tagId".');
    return true;
  } catch (e) {
    print('Update Scan Time Error: $e');
    return false;
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
