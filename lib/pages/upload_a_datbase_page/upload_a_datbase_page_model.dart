import '/components/file_requirement_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'upload_a_datbase_page_widget.dart' show UploadADatbasePageWidget;
import 'package:flutter/material.dart';

class UploadADatbasePageModel
    extends FlutterFlowModel<UploadADatbasePageWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading_uploadDataOpn = false;
  FFUploadedFile uploadedLocalFile_uploadDataOpn =
      FFUploadedFile(bytes: Uint8List.fromList([]), originalFilename: '');

  // Stores action output result for [Custom Action - mergeUploadedDatabase] action in Container widget.
  String? isSyncOk;
  // Model for FileRequirement.
  late FileRequirementModel fileRequirementModel1;
  // Model for FileRequirement.
  late FileRequirementModel fileRequirementModel2;
  // Model for FileRequirement.
  late FileRequirementModel fileRequirementModel3;
  // Model for FileRequirement.
  late FileRequirementModel fileRequirementModel4;

  @override
  void initState(BuildContext context) {
    fileRequirementModel1 = createModel(context, () => FileRequirementModel());
    fileRequirementModel2 = createModel(context, () => FileRequirementModel());
    fileRequirementModel3 = createModel(context, () => FileRequirementModel());
    fileRequirementModel4 = createModel(context, () => FileRequirementModel());
  }

  @override
  void dispose() {
    fileRequirementModel1.dispose();
    fileRequirementModel2.dispose();
    fileRequirementModel3.dispose();
    fileRequirementModel4.dispose();
  }
}
