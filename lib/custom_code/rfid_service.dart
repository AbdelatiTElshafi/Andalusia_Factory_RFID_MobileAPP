import 'package:flutter/services.dart';

class RFIDService {
  static const MethodChannel _channel = MethodChannel('rfid_channel');

  static Future<bool> connectRFID() async {
    try {
      print("RFID: Calling connectRFID...");
      final bool? result = await _channel.invokeMethod<bool>('connectRFID');
      print("RFID: connectRFID result = $result");
      return result ?? false;
    } catch (e, s) {
      print("RFID ERROR connectRFID: $e");
      print(s);
      return false;
    }
  }

  static Future<bool> startScan() async {
    try {
      print("RFID: Calling startScan...");
      final bool? result = await _channel.invokeMethod<bool>('startScan');
      print("RFID: startScan result = $result");
      return result ?? false;
    } catch (e, s) {
      print("RFID ERROR startScan: $e");
      print(s);
      return false;
    }
  }

  static Future<bool> stopScan() async {
    try {
      print("RFID: Calling stopScan...");
      final bool? result = await _channel.invokeMethod<bool>('stopScan');
      print("RFID: stopScan result = $result");
      return result ?? false;
    } catch (e, s) {
      print("RFID ERROR stopScan: $e");
      print(s);
      return false;
    }
  }

  static Future<bool> disableRFID() async {
    try {
      print("RFID: Calling disableRFID...");
      final bool? result = await _channel.invokeMethod<bool>('disableRFID');
      print("RFID: disableRFID result = $result");
      return result ?? false;
    } catch (e, s) {
      print("RFID ERROR disableRFID: $e");
      print(s);
      return false;
    }
  }

  static Future<bool> disconnectRFID() async {
    try {
      print("RFID: Calling disconnectRFID...");
      final bool? result = await _channel.invokeMethod<bool>('disconnectRFID');
      print("RFID: disconnectRFID result = $result");
      return result ?? false;
    } catch (e, s) {
      print("RFID ERROR disconnectRFID: $e");
      print(s);
      return false;
    }
  }

  static void setTagReadListener(Function(List<String> tags) onTagsRead) {
    _channel.setMethodCallHandler((call) async {
      print("RFID EVENT: ${call.method}");

      if (call.method == 'onTagRead') {
        final args = call.arguments;
        List<String> tags = [];

        if (args is List) {
          tags = args.map((e) => e.toString()).toList();
        } else if (args is String) {
          tags = [args];
        } else if (args != null) {
          tags = [args.toString()];
        }

        print("RFID TAGS: $tags");
        onTagsRead(tags);
      }
    });
  }
}
