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

Future<bool> calculateAndUpdateStageDuration(
  String host,
  int port,
  String dbName,
  String user,
  String password,
  String tagId,
  String startTimeColumn,
  String endTimeColumn,
  String durationColumn,
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
      print('Duration Error: Failed to connect to MySQL database.');
      return false;
    }

    // 2. Query the start and end time columns for the specified TAG_ID
    final fetchQuery =
        'SELECT `$startTimeColumn` AS start_val, `$endTimeColumn` AS end_val FROM AN_RFID WHERE TAG_ID = :tagId';

    final result = await mysqlConn.execute(fetchQuery, {'tagId': tagId});

    if (result.rows.isEmpty) {
      print('Duration Error: TAG_ID "$tagId" not found in AN_RFID.');
      return false;
    }

    final rowData = result.rows.first.assoc();
    final startStr = rowData['start_val'];
    final endStr = rowData['end_val'];

    if (startStr == null ||
        endStr == null ||
        startStr.isEmpty ||
        endStr.isEmpty) {
      print(
          'Duration Error: One or both timestamp columns ("$startTimeColumn", "$endTimeColumn") are empty or null.');
      return false;
    }

    // 3. Parse formatted timestamp strings ("YYYY-MM-DD HH:MM:SS") into DateTime objects
    final startDt = DateTime.parse(startStr.replaceAll(' ', 'T'));
    final endDt = DateTime.parse(endStr.replaceAll(' ', 'T'));

    // 4. Calculate duration in minutes (whole minutes)
    final durationInMinutes = endDt.difference(startDt).inMinutes;

    // 5. Update the duration column for the specified TAG_ID
    final updateQuery =
        'UPDATE AN_RFID SET `$durationColumn` = :durationVal WHERE TAG_ID = :tagId';

    await mysqlConn.execute(
      updateQuery,
      {
        'durationVal':
            durationInMinutes.toString(), // Saved as string (total minutes)
        'tagId': tagId,
      },
    );

    print(
        'Duration Success: Stage duration between "$startTimeColumn" and "$endTimeColumn" saved to "$durationColumn" ($durationInMinutes minutes) for TAG_ID "$tagId".');
    return true;
  } catch (e) {
    print('Calculate Duration Error: $e');
    return false;
  } finally {
    // 6. Safe connection cleanup
    try {
      if (mysqlConn != null && mysqlConn.connected) {
        await mysqlConn.close();
      }
    } catch (_) {}
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
