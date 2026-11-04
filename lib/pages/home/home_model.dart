import '/components/loading/loading_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'home_widget.dart' show HomeWidget;
import 'package:flutter/material.dart';

class HomeModel extends FlutterFlowModel<HomeWidget> {
  ///  Local state fields for this page.

  String rfidStatus = 'connecting';

  List<String> test = ['Hello World', 'Hello World1', 'Hello World2'];
  void addToTest(String item) => test.add(item);
  void removeFromTest(String item) => test.remove(item);
  void removeAtIndexFromTest(int index) => test.removeAt(index);
  void insertAtIndexInTest(int index, String item) => test.insert(index, item);
  void updateTestAtIndex(int index, Function(String) updateFn) =>
      test[index] = updateFn(test[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Custom Action - updateSqliteProductsFromMysql] action in Container widget.
  bool? sqlupdate;
  // Stores action output result for [Custom Action - syncSqliteToMysql] action in Container widget.
  bool? syncstatus;
  // Model for Loading component.
  late LoadingModel loadingModel;

  @override
  void initState(BuildContext context) {
    loadingModel = createModel(context, () => LoadingModel());
  }

  @override
  void dispose() {
    loadingModel.dispose();
  }
}
