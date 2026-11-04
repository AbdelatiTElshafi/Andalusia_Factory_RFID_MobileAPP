import '/backend/sqlite/sqlite_manager.dart';
import '/components/button2_widget.dart';
import '/components/stat_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'r_f_i_d_scanning_widget.dart' show RFIDScanningWidget;
import 'package:flutter/material.dart';

class RFIDScanningModel extends FlutterFlowModel<RFIDScanningWidget> {
  ///  Local state fields for this page.

  List<String> allOrderRFIDList = [];
  void addToAllOrderRFIDList(String item) => allOrderRFIDList.add(item);
  void removeFromAllOrderRFIDList(String item) => allOrderRFIDList.remove(item);
  void removeAtIndexFromAllOrderRFIDList(int index) =>
      allOrderRFIDList.removeAt(index);
  void insertAtIndexInAllOrderRFIDList(int index, String item) =>
      allOrderRFIDList.insert(index, item);
  void updateAllOrderRFIDListAtIndex(int index, Function(String) updateFn) =>
      allOrderRFIDList[index] = updateFn(allOrderRFIDList[index]);

  int? savedTagsCount = 0;

  List<String> newScannedRFIDTags = [];
  void addToNewScannedRFIDTags(String item) => newScannedRFIDTags.add(item);
  void removeFromNewScannedRFIDTags(String item) =>
      newScannedRFIDTags.remove(item);
  void removeAtIndexFromNewScannedRFIDTags(int index) =>
      newScannedRFIDTags.removeAt(index);
  void insertAtIndexInNewScannedRFIDTags(int index, String item) =>
      newScannedRFIDTags.insert(index, item);
  void updateNewScannedRFIDTagsAtIndex(int index, Function(String) updateFn) =>
      newScannedRFIDTags[index] = updateFn(newScannedRFIDTags[index]);

  bool startListen = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - SQLite (GetInventoryItems)] action in RFIDScanning widget.
  List<GetInventoryItemsRow>? getInventoryItems;
  // Stores action output result for [Custom Action - checkStringInList] action in RFIDScanning widget.
  bool? exist;
  // Model for StatCard.
  late StatCardModel statCardModel1;
  // Model for StatCard.
  late StatCardModel statCardModel2;
  // Stores action output result for [Backend Call - SQLite (GetTagData)] action in Button widget.
  List<GetTagDataRow>? tagData;
  // Model for Button.
  late Button2Model buttonModel;

  @override
  void initState(BuildContext context) {
    statCardModel1 = createModel(context, () => StatCardModel());
    statCardModel2 = createModel(context, () => StatCardModel());
    buttonModel = createModel(context, () => Button2Model());
  }

  @override
  void dispose() {
    statCardModel1.dispose();
    statCardModel2.dispose();
    buttonModel.dispose();
  }
}
