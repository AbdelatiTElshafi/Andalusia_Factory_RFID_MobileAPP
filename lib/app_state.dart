import 'package:flutter/material.dart'
    show ChangeNotifier, Color, Colors, VoidCallback;
import 'package:shared_preferences/shared_preferences.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _host = prefs.getString('ff_host') ?? _host;
    });
    _safeInit(() {
      _user = prefs.getString('ff_user') ?? _user;
    });
    _safeInit(() {
      _password = prefs.getString('ff_password') ?? _password;
    });
    _safeInit(() {
      _dbname = prefs.getString('ff_dbname') ?? _dbname;
    });
    _safeInit(() {
      _port = prefs.getInt('ff_port') ?? _port;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _rfidStatus = 'Disconnected';
  String get rfidStatus => _rfidStatus;
  set rfidStatus(String value) {
    _rfidStatus = value;
  }

  String _scannedTagId = '';
  String get scannedTagId => _scannedTagId;
  set scannedTagId(String value) {
    _scannedTagId = value;
  }

  bool _rfidConnected = false;
  bool get rfidConnected => _rfidConnected;
  set rfidConnected(bool value) {
    _rfidConnected = value;
  }

  List<String> _scannedTagList = [];
  List<String> get scannedTagList => _scannedTagList;
  set scannedTagList(List<String> value) {
    _scannedTagList = value;
  }

  void addToScannedTagList(String value) {
    scannedTagList.add(value);
  }

  void removeFromScannedTagList(String value) {
    scannedTagList.remove(value);
  }

  void removeAtIndexFromScannedTagList(int index) {
    scannedTagList.removeAt(index);
  }

  void updateScannedTagListAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    scannedTagList[index] = updateFn(_scannedTagList[index]);
  }

  void insertAtIndexInScannedTagList(int index, String value) {
    scannedTagList.insert(index, value);
  }

  String _host = '';
  String get host => _host;
  set host(String value) {
    _host = value;
    prefs.setString('ff_host', value);
  }

  String _user = '';
  String get user => _user;
  set user(String value) {
    _user = value;
    prefs.setString('ff_user', value);
  }

  String _password = '';
  String get password => _password;
  set password(String value) {
    _password = value;
    prefs.setString('ff_password', value);
  }

  String _dbname = '';
  String get dbname => _dbname;
  set dbname(String value) {
    _dbname = value;
    prefs.setString('ff_dbname', value);
  }

  int _port = 0;
  int get port => _port;
  set port(int value) {
    _port = value;
    prefs.setInt('ff_port', value);
  }

  bool _loadingvis = false;
  bool get loadingvis => _loadingvis;
  set loadingvis(bool value) {
    _loadingvis = value;
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
