import '/components/input_label/input_label_widget.dart';
import '/components/text_field2/text_field2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'create_inventory_widget.dart' show CreateInventoryWidget;
import 'package:flutter/material.dart';

class CreateInventoryModel extends FlutterFlowModel<CreateInventoryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for InputLabel.
  late InputLabelModel inputLabelModel1;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Model for InputLabel.
  late InputLabelModel inputLabelModel2;
  // Model for NotesTextField.
  late TextField2Model notesTextFieldModel;

  @override
  void initState(BuildContext context) {
    inputLabelModel1 = createModel(context, () => InputLabelModel());
    inputLabelModel2 = createModel(context, () => InputLabelModel());
    notesTextFieldModel = createModel(context, () => TextField2Model());
  }

  @override
  void dispose() {
    inputLabelModel1.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();

    inputLabelModel2.dispose();
    notesTextFieldModel.dispose();
  }
}
