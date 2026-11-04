import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'saved_tags_widget.dart' show SavedTagsWidget;
import 'package:flutter/material.dart';

class SavedTagsModel extends FlutterFlowModel<SavedTagsWidget> {
  ///  Local state fields for this page.

  List<String> tagsID = [];
  void addToTagsID(String item) => tagsID.add(item);
  void removeFromTagsID(String item) => tagsID.remove(item);
  void removeAtIndexFromTagsID(int index) => tagsID.removeAt(index);
  void insertAtIndexInTagsID(int index, String item) =>
      tagsID.insert(index, item);
  void updateTagsIDAtIndex(int index, Function(String) updateFn) =>
      tagsID[index] = updateFn(tagsID[index]);

  List<String> serials = [];
  void addToSerials(String item) => serials.add(item);
  void removeFromSerials(String item) => serials.remove(item);
  void removeAtIndexFromSerials(int index) => serials.removeAt(index);
  void insertAtIndexInSerials(int index, String item) =>
      serials.insert(index, item);
  void updateSerialsAtIndex(int index, Function(String) updateFn) =>
      serials[index] = updateFn(serials[index]);

  List<String> name = [];
  void addToName(String item) => name.add(item);
  void removeFromName(String item) => name.remove(item);
  void removeAtIndexFromName(int index) => name.removeAt(index);
  void insertAtIndexInName(int index, String item) => name.insert(index, item);
  void updateNameAtIndex(int index, Function(String) updateFn) =>
      name[index] = updateFn(name[index]);

  List<String> partNOs = [];
  void addToPartNOs(String item) => partNOs.add(item);
  void removeFromPartNOs(String item) => partNOs.remove(item);
  void removeAtIndexFromPartNOs(int index) => partNOs.removeAt(index);
  void insertAtIndexInPartNOs(int index, String item) =>
      partNOs.insert(index, item);
  void updatePartNOsAtIndex(int index, Function(String) updateFn) =>
      partNOs[index] = updateFn(partNOs[index]);

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - SQLite (GetAllTags)] action in SavedTags widget.
  List<GetAllTagsRow>? allTagsDataPage;
  // Stores action output result for [Backend Call - SQLite (GetAllTags)] action in Button widget.
  List<GetAllTagsRow>? allTagsData;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
