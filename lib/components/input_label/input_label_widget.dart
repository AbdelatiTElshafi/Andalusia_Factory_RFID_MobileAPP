import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'input_label_model.dart';
export 'input_label_model.dart';

class InputLabelWidget extends StatefulWidget {
  const InputLabelWidget({
    super.key,
    String? label,
  }) : this.label = label ?? 'Inventory No';

  final String label;

  @override
  State<InputLabelWidget> createState() => _InputLabelWidgetState();
}

class _InputLabelWidgetState extends State<InputLabelWidget> {
  late InputLabelModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InputLabelModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
      child: Container(
        child: Text(
          valueOrDefault<String>(
            widget.label,
            'Inventory No',
          ),
          style: FlutterFlowTheme.of(context).labelMedium.override(
                font: GoogleFonts.ibmPlexSansArabic(
                  fontWeight:
                      FlutterFlowTheme.of(context).labelMedium.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
                lineHeight: 1.3,
              ),
        ),
      ),
    );
  }
}
