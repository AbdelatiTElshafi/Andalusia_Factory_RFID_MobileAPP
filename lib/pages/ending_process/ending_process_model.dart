import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'ending_process_widget.dart' show EndingProcessWidget;
import 'package:flutter/material.dart';

class EndingProcessModel extends FlutterFlowModel<EndingProcessWidget> {
  ///  Local state fields for this page.

  String scannedTagId = ' test';

  List<String> partsno = [];
  void addToPartsno(String item) => partsno.add(item);
  void removeFromPartsno(String item) => partsno.remove(item);
  void removeAtIndexFromPartsno(int index) => partsno.removeAt(index);
  void insertAtIndexInPartsno(int index, String item) =>
      partsno.insert(index, item);
  void updatePartsnoAtIndex(int index, Function(String) updateFn) =>
      partsno[index] = updateFn(partsno[index]);

  ///  State fields for stateful widgets in this page.

  // State field(s) for TAGIDText widget.
  final tAGIDTextKey = GlobalKey();
  FocusNode? tAGIDTextFocusNode;
  TextEditingController? tAGIDTextTextController;
  String? tAGIDTextSelectedOption;
  String? Function(BuildContext, String?)? tAGIDTextTextControllerValidator;
  // Stores action output result for [Custom Action - getRfidDescription] action in TAGIDText widget.
  String? tagdesc;
  // State field(s) for DescTextField widget.
  FocusNode? descTextFieldFocusNode;
  TextEditingController? descTextFieldTextController;
  String? Function(BuildContext, String?)? descTextFieldTextControllerValidator;
  // Stores action output result for [Custom Action - checkRfidTagExists] action in Button widget.
  bool? checktag;
  // Stores action output result for [Custom Action - updateRfidScanTime] action in Button widget.
  bool? timeadded;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tAGIDTextFocusNode?.dispose();

    descTextFieldFocusNode?.dispose();
    descTextFieldTextController?.dispose();
  }
}
