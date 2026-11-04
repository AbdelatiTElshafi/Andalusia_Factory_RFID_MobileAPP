import 'package:flutter/foundation.dart';

import '/backend/sqlite/init.dart';
import 'queries/read.dart';
import 'queries/update.dart';

import 'package:sqflite/sqflite.dart';
export 'queries/read.dart';
export 'queries/update.dart';

class SQLiteManager {
  SQLiteManager._();

  static SQLiteManager? _instance;
  static SQLiteManager get instance => _instance ??= SQLiteManager._();

  static late Database _database;
  Database get database => _database;

  static Future initialize() async {
    if (kIsWeb) {
      return;
    }
    _database = await initializeDatabaseFromDbFile(
      'rfiddb',
      'rfiddb.db',
    );
  }

  /// START READ QUERY CALLS

  Future<List<GetAllTagsRow>> getAllTags() => performGetAllTags(
        _database,
      );

  Future<List<SearchTagsRow>> searchTags({
    String? searchText,
  }) =>
      performSearchTags(
        _database,
        searchText: searchText,
      );

  Future<List<GetTagDataRow>> getTagData({
    String? tagId,
  }) =>
      performGetTagData(
        _database,
        tagId: tagId,
      );

  Future<List<GetAllPartNORow>> getAllPartNO({
    String? partno,
  }) =>
      performGetAllPartNO(
        _database,
        partno: partno,
      );

  Future<List<GetPartNoDescRow>> getPartNoDesc({
    String? partnumber,
  }) =>
      performGetPartNoDesc(
        _database,
        partnumber: partnumber,
      );

  Future<List<GetInventoryOrdersRow>> getInventoryOrders() =>
      performGetInventoryOrders(
        _database,
      );

  Future<List<GetInventoryItemsRow>> getInventoryItems({
    String? inventoryorderid,
  }) =>
      performGetInventoryItems(
        _database,
        inventoryorderid: inventoryorderid,
      );

  /// END READ QUERY CALLS

  /// START UPDATE QUERY CALLS

  Future insertTag({
    String? nameDesc,
    String? serialNumber,
    String? tagId,
    String? partNo,
  }) =>
      performInsertTag(
        _database,
        nameDesc: nameDesc,
        serialNumber: serialNumber,
        tagId: tagId,
        partNo: partNo,
      );

  Future updateTag({
    String? nameDesc,
    String? serialNumber,
    String? tagId,
  }) =>
      performUpdateTag(
        _database,
        nameDesc: nameDesc,
        serialNumber: serialNumber,
        tagId: tagId,
      );

  Future deleteTag({
    String? tagId,
  }) =>
      performDeleteTag(
        _database,
        tagId: tagId,
      );

  Future createInventoryOrder({
    String? inventoryno,
    DateTime? starttime,
    String? status,
  }) =>
      performCreateInventoryOrder(
        _database,
        inventoryno: inventoryno,
        starttime: starttime,
        status: status,
      );

  Future saveTagsToInventoryOrders({
    String? inventoryorderid,
    String? tagid,
    String? scantime,
    String? partno,
    String? serial,
    String? name,
  }) =>
      performSaveTagsToInventoryOrders(
        _database,
        inventoryorderid: inventoryorderid,
        tagid: tagid,
        scantime: scantime,
        partno: partno,
        serial: serial,
        name: name,
      );

  Future updateIneventoryOrder({
    String? status,
    String? inventoryno,
  }) =>
      performUpdateIneventoryOrder(
        _database,
        status: status,
        inventoryno: inventoryno,
      );

  /// END UPDATE QUERY CALLS
}
