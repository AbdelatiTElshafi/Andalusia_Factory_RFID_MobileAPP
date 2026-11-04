import '/components/button/button_widget.dart';
import '/components/status_badge/status_badge_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'session_card_widget.dart' show SessionCardWidget;
import 'package:flutter/material.dart';

class SessionCardModel extends FlutterFlowModel<SessionCardWidget> {
  ///  State fields for stateful widgets in this component.

  // Model for StatusBadge.
  late StatusBadgeModel statusBadgeModel;
  // Model for Button.
  late ButtonModel buttonModel;

  @override
  void initState(BuildContext context) {
    statusBadgeModel = createModel(context, () => StatusBadgeModel());
    buttonModel = createModel(context, () => ButtonModel());
  }

  @override
  void dispose() {
    statusBadgeModel.dispose();
    buttonModel.dispose();
  }
}
