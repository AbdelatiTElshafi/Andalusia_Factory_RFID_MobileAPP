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

Future<bool> checkStringInList(
  String input,
  List<String> list,
) async {
  /// MODIFY CODE ONLY BELOW THIS LINE

  // تنظيف input: إزالة المسافات/الإنتر وتحويل لحروف صغيرة
  final cleanInput =
      input.toString().replaceAll(RegExp(r'\s+'), '').toLowerCase();

  // تنظيف عناصر الليست بنفس الطريقة
  final cleanList = list
      .map((e) => e.toString().replaceAll(RegExp(r'\s+'), '').toLowerCase())
      .toList();

  // مقارنة بعد التنظيف
  return cleanList.contains(cleanInput);

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
