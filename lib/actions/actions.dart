import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';

Future test(BuildContext context) async {
  await actions.rfidConnection();
}
