import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file_requirement_model.dart';
export 'file_requirement_model.dart';

class FileRequirementWidget extends StatefulWidget {
  const FileRequirementWidget({
    super.key,
    this.icon,
    String? label,
  }) : this.label = label ?? 'Ensure schema matches KKKK v2.4';

  final Widget? icon;
  final String label;

  @override
  State<FileRequirementWidget> createState() => _FileRequirementWidgetState();
}

class _FileRequirementWidgetState extends State<FileRequirementWidget> {
  late FileRequirementModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FileRequirementModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        widget.icon!,
        Text(
          valueOrDefault<String>(
            widget.label,
            'Ensure schema matches KKKK v2.4',
          ),
          style: FlutterFlowTheme.of(context).bodySmall.override(
                font: GoogleFonts.ibmPlexSansArabic(
                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                  fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).secondaryText,
                letterSpacing: 0.0,
                fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                fontStyle: FlutterFlowTheme.of(context).bodySmall.fontStyle,
                lineHeight: 1.4,
              ),
        ),
      ].divide(SizedBox(width: 8.0)),
    );
  }
}
