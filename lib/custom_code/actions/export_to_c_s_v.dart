// Automatic FlutterFlow imports
import '/backend/sqlite/sqlite_manager.dart';
import '/actions/actions.dart' as action_blocks;
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart' hide RepeatMode;
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportToCSV(
  List<String> tagIds,
  List<String> names,
  List<String> partNumbers,
  List<String> serialNumbers,
) async {
  if (tagIds.length != names.length ||
      tagIds.length != partNumbers.length ||
      tagIds.length != serialNumbers.length) {
    throw Exception('All input lists must have the same length.');
  }

  final rows = <List<dynamic>>[];

  rows.add([
    'tag_id',
    'name_description',
    'part_number',
    'Serial_No',
  ]);

  for (int i = 0; i < tagIds.length; i++) {
    rows.add([
      tagIds[i],
      names[i],
      partNumbers[i],
      serialNumbers[i],
    ]);
  }

  final csvString = const ListToCsvConverter().convert(rows);

  final dir = await getApplicationDocumentsDirectory();
  final now = DateTime.now().millisecondsSinceEpoch;
  final path = '${dir.path}/export_$now.csv';

  final file = File(path);
  await file.writeAsString(csvString);

  await Share.shareFiles(
    [path],
    text: 'Exported CSV',
    subject: 'CSV Export',
  );
}
