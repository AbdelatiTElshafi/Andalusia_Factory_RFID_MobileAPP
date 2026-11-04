import '/backend/sqlite/sqlite_manager.dart';
import '/components/button3_widget.dart';
import '/components/export_option_card_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'inventoryactions_widget.dart' show InventoryactionsWidget;
import 'package:flutter/material.dart';

class InventoryactionsModel extends FlutterFlowModel<InventoryactionsWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for ExportOptionCard.
  late ExportOptionCardModel exportOptionCardModel1;
  // Model for ExportOptionCard.
  late ExportOptionCardModel exportOptionCardModel2;
  // Model for ExportOptionCard.
  late ExportOptionCardModel exportOptionCardModel3;
  // Stores action output result for [Backend Call - SQLite (GetInventoryItems)] action in ExportOptionCard widget.
  List<GetInventoryItemsRow>? inventoryItemsData;
  // Model for Button.
  late Button3Model buttonModel;

  @override
  void initState(BuildContext context) {
    exportOptionCardModel1 =
        createModel(context, () => ExportOptionCardModel());
    exportOptionCardModel2 =
        createModel(context, () => ExportOptionCardModel());
    exportOptionCardModel3 =
        createModel(context, () => ExportOptionCardModel());
    buttonModel = createModel(context, () => Button3Model());
  }

  @override
  void dispose() {
    exportOptionCardModel1.dispose();
    exportOptionCardModel2.dispose();
    exportOptionCardModel3.dispose();
    buttonModel.dispose();
  }
}
