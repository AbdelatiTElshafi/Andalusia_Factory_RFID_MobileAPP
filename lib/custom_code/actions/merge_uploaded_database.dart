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
import 'dart:io';
import 'dart:convert';

Future<String> mergeUploadedDatabase(FFUploadedFile? uploadedFile) async {
  if (uploadedFile == null || uploadedFile.bytes == null) {
    return "Error: No file was selected.";
  }

  try {
    var databasesPath = await getDatabasesPath();
    String mainDbPath = join(databasesPath, 'rfiddb.db');

    bool dbExists = await databaseExists(mainDbPath);
    if (!dbExists) {
      return "Error: Local database 'rfiddb.db' not found. Please open your product catalog screen first.";
    }

    // Decode safely - Automatically handles UTF-8 and Windows Arabic layouts
    String csvContent;
    try {
      csvContent = utf8.decode(uploadedFile.bytes!);
    } catch (_) {
      List<int> bytes = uploadedFile.bytes!;
      StringBuffer sb = StringBuffer();
      for (int b in bytes) {
        if (b >= 0x80) {
          const cp1256 = [
            0x20AC,
            0x067E,
            0x201A,
            0x0192,
            0x201E,
            0x2026,
            0x2020,
            0x2021,
            0x02C6,
            0x2030,
            0x0671,
            0x2039,
            0x0152,
            0x0690,
            0x0688,
            0x0686,
            0x0640,
            0x2018,
            0x2019,
            0x201C,
            0x201D,
            0x2022,
            0x2013,
            0x2014,
            0x0631,
            0x2122,
            0x0632,
            0x203A,
            0x0153,
            0x200C,
            0x200D,
            0x064A,
            0x00A0,
            0x061B,
            0x00A2,
            0x00A3,
            0x00A4,
            0x00A5,
            0x00A6,
            0x00A7,
            0x00A8,
            0x00A9,
            0x06AF,
            0x00AB,
            0x00AC,
            0x00AD,
            0x00AE,
            0x00AF,
            0x00B0,
            0x00B1,
            0x00B2,
            0x00B3,
            0x00B4,
            0x00B5,
            0x00B6,
            0x00B7,
            0x00B8,
            0x060C,
            0x00BA,
            0x00BB,
            0x00BC,
            0x00BD,
            0x00BE,
            0x061F,
            0x06C1,
            0x0621,
            0x0622,
            0x0623,
            0x0624,
            0x0625,
            0x0626,
            0x0627,
            0x0628,
            0x0629,
            0x062A,
            0x062B,
            0x062C,
            0x062D,
            0x062E,
            0x062F,
            0x0630,
            0x0631,
            0x0632,
            0x0633,
            0x0634,
            0x0635,
            0x0636,
            0x00D7,
            0x0637,
            0x0638,
            0x0639,
            0x063A,
            0x0641,
            0x0642,
            0x0643,
            0x0644,
            0x0645,
            0x0646,
            0x0647,
            0x0648,
            0x00F7,
            0x0649,
            0x064A,
            0x064B,
            0x064C,
            0x064D,
            0x064E,
            0x064F,
            0x0650,
            0x0651,
            0x0652,
            0x06C0
          ];
          sb.writeCharCode(cp1256[b - 0x80]);
        } else {
          sb.writeCharCode(b);
        }
      }
      csvContent = sb.toString();
    }

    csvContent = csvContent.replaceAll('\r', '');
    List<String> lines = csvContent.split('\n');
    lines.removeWhere((line) => line.trim().isEmpty);

    if (lines.isEmpty) {
      return "Error: The uploaded CSV file is empty.";
    }

    List<String> headers = _splitCsvLine(lines.first);
    int nameColumnIndex = -1;
    int brandColumnIndex = -1;
    int referenceColumnIndex = -1;

    for (int i = 0; i < headers.length; i++) {
      String headerValue = headers[i].trim().toLowerCase();
      if (headerValue == 'name') nameColumnIndex = i;
      if (headerValue == 'brand') brandColumnIndex = i;
      if (headerValue == 'internal reference' ||
          headerValue == 'internal_reference') {
        referenceColumnIndex = i;
      }
    }

    if (referenceColumnIndex == -1) {
      return "Template Error: Could not find 'Internal Reference' column header.";
    }

    Database mainDb = await openDatabase(mainDbPath);

    // High-speed transaction processing block
    await mainDb.transaction((txn) async {
      for (int i = 1; i < lines.length; i++) {
        List<String> columns = _splitCsvLine(lines[i]);
        if (columns.length <= referenceColumnIndex) continue;

        String refValue = columns[referenceColumnIndex].trim();
        if (refValue.isEmpty) continue;

        String nameDescriptionValue =
            nameColumnIndex != -1 && nameColumnIndex < columns.length
                ? columns[nameColumnIndex].trim()
                : '';

        String brandValue =
            brandColumnIndex != -1 && brandColumnIndex < columns.length
                ? columns[brandColumnIndex].trim()
                : '';

        // 1. Check if an item already exists under this part_number string
        List<Map<String, dynamic>> existingRows = await txn.rawQuery(
            'SELECT id FROM Products WHERE part_number = ? LIMIT 1',
            [refValue]);

        if (existingRows.isNotEmpty) {
          // 2. Row exists: Update details targeting the local item integer ID
          await txn.rawUpdate('''
            UPDATE Products 
            SET name_description = ?, Brand = ?
            WHERE id = ?
          ''', [nameDescriptionValue, brandValue, existingRows.first['id']]);
        } else {
          // 3. New record: Insert description and code, omitting 'id' so it auto-increments cleanly
          await txn.rawInsert('''
            INSERT INTO Products (name_description, Brand, part_number)
            VALUES (?, ?, ?)
          ''', [nameDescriptionValue, brandValue, refValue]);
        }
      }
    });

    await mainDb.close();
    return "Success";
  } catch (systemError) {
    return "Device File System Error: $systemError";
  }
}

List<String> _splitCsvLine(String line) {
  List<String> result = [];
  StringBuffer currentCell = StringBuffer();
  bool insideQuotes = false;

  for (int i = 0; i < line.length; i++) {
    String char = line[i];

    if (char == '"') {
      insideQuotes = !insideQuotes;
    } else if (char == ',' && !insideQuotes) {
      result.add(currentCell.toString());
      currentCell.clear();
    } else {
      currentCell.write(char);
    }
  }
  result.add(currentCell.toString());
  return result;
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the `</>` button on the right!
