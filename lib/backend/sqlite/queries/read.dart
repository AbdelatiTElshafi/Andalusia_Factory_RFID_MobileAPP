import '/backend/sqlite/queries/sqlite_row.dart';
import 'package:sqflite/sqflite.dart';

Future<List<T>> _readQuery<T>(
  Database database,
  String query,
  T Function(Map<String, dynamic>) create,
) =>
    database.rawQuery(query).then((r) => r.map((e) => create(e)).toList());

/// BEGIN GETALLTAGS
Future<List<GetAllTagsRow>> performGetAllTags(
  Database database,
) {
  final query = '''
SELECT * FROM saved_tags;
''';
  return _readQuery(database, query, (d) => GetAllTagsRow(d));
}

class GetAllTagsRow extends SqliteRow {
  GetAllTagsRow(Map<String, dynamic> data) : super(data);

  String? get nameDescription => data['name_description'] as String?;
  String? get serialNumber => data['serial_number'] as String?;
  String? get tagId => data['tag_id'] as String?;
  String? get partNumber => data['part_number'] as String?;
}

/// END GETALLTAGS

/// BEGIN SEARCHTAGS
Future<List<SearchTagsRow>> performSearchTags(
  Database database, {
  String? searchText,
}) {
  final query = '''
SELECT
  name_description,
  serial_number,
  tag_id
FROM saved_tags
WHERE
  '${searchText}' = ''
  OR name_description LIKE '%' || '${searchText}' || '%'
  OR serial_number LIKE '%' || '${searchText}' || '%'
  OR tag_id LIKE '%' || '${searchText}' || '%'
ORDER BY rowid DESC;
''';
  return _readQuery(database, query, (d) => SearchTagsRow(d));
}

class SearchTagsRow extends SqliteRow {
  SearchTagsRow(Map<String, dynamic> data) : super(data);

  String? get nameDescription => data['name_description'] as String?;
  String? get serialNumber => data['serial_number'] as String?;
  String? get tagId => data['tag_id'] as String?;
}

/// END SEARCHTAGS

/// BEGIN GETTAGDATA
Future<List<GetTagDataRow>> performGetTagData(
  Database database, {
  String? tagId,
}) {
  final query = '''
SELECT * FROM saved_tags
WHERE tag_id = '${tagId}';
''';
  return _readQuery(database, query, (d) => GetTagDataRow(d));
}

class GetTagDataRow extends SqliteRow {
  GetTagDataRow(Map<String, dynamic> data) : super(data);

  String? get tagId => data['tag_Id'] as String?;
  String? get nameDescription => data['name_description'] as String?;
  String? get serialNumber => data['serial_number'] as String?;
  String? get partNumber => data['part_number'] as String?;
}

/// END GETTAGDATA

/// BEGIN GETALLPARTNO
Future<List<GetAllPartNORow>> performGetAllPartNO(
  Database database, {
  String? partno,
}) {
  final query = '''
SELECT part_number
FROM Products
WHERE part_number LIKE '${partno}'
ORDER BY part_number ASC
LIMIT 100;
''';
  return _readQuery(database, query, (d) => GetAllPartNORow(d));
}

class GetAllPartNORow extends SqliteRow {
  GetAllPartNORow(Map<String, dynamic> data) : super(data);

  String? get partNumber => data['part_number'] as String?;
}

/// END GETALLPARTNO

/// BEGIN GETPARTNODESC
Future<List<GetPartNoDescRow>> performGetPartNoDesc(
  Database database, {
  String? partnumber,
}) {
  final query = '''
SELECT * FROM Products
WHERE part_number = '${partnumber}';
''';
  return _readQuery(database, query, (d) => GetPartNoDescRow(d));
}

class GetPartNoDescRow extends SqliteRow {
  GetPartNoDescRow(Map<String, dynamic> data) : super(data);

  String? get nameDescription => data['name_description'] as String?;
}

/// END GETPARTNODESC

/// BEGIN GETINVENTORYORDERS
Future<List<GetInventoryOrdersRow>> performGetInventoryOrders(
  Database database,
) {
  final query = '''
SELECT *
FROM inventory_orders
WHERE status != 'deleted'
ORDER BY id DESC;
''';
  return _readQuery(database, query, (d) => GetInventoryOrdersRow(d));
}

class GetInventoryOrdersRow extends SqliteRow {
  GetInventoryOrdersRow(Map<String, dynamic> data) : super(data);

  String? get inventoryNo => data['inventory_no'] as String?;
  String? get startTime => data['start_time'] as String?;
  String? get status => data['status'] as String?;
}

/// END GETINVENTORYORDERS

/// BEGIN GETINVENTORYITEMS
Future<List<GetInventoryItemsRow>> performGetInventoryItems(
  Database database, {
  String? inventoryorderid,
}) {
  final query = '''
SELECT * FROM inventory_items
WHERE inventory_order_id = '${inventoryorderid}';
''';
  return _readQuery(database, query, (d) => GetInventoryItemsRow(d));
}

class GetInventoryItemsRow extends SqliteRow {
  GetInventoryItemsRow(Map<String, dynamic> data) : super(data);

  String? get tagId => data['tag_id'] as String?;
  String? get partNo => data['part_no'] as String?;
  String? get serial => data['serial'] as String?;
  String? get name => data['name'] as String?;
}

/// END GETINVENTORYITEMS
