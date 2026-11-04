import '/components/button/button_widget.dart';
import '/components/inventoryactions_widget.dart';
import '/components/status_badge/status_badge_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'session_card_model.dart';
export 'session_card_model.dart';

class SessionCardWidget extends StatefulWidget {
  const SessionCardWidget({
    super.key,
    String? count,
    String? date,
    String? location,
    String? session_id,
    String? status,
  })  : this.count = count ?? '1,240',
        this.date = date ?? 'Oct 24, 2023 • 09:15 AM',
        this.location = location ?? 'North Warehouse - Zone A',
        this.session_id = session_id ?? 'INV-2023-0891',
        this.status = status ?? 'Completed';

  final String count;
  final String date;
  final String location;
  final String session_id;
  final String status;

  @override
  State<SessionCardWidget> createState() => _SessionCardWidgetState();
}

class _SessionCardWidgetState extends State<SessionCardWidget> {
  late SessionCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SessionCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
      child: Container(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(24.0),
            shape: BoxShape.rectangle,
            border: Border.all(
              color: FlutterFlowTheme.of(context).alternate,
              width: 1.0,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Container(
              decoration: BoxDecoration(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.session_id,
                          'INV-2023-0891',
                        ),
                        style:
                            FlutterFlowTheme.of(context).titleMedium.override(
                                  font: GoogleFonts.ibmPlexSansArabic(
                                    fontWeight: FontWeight.bold,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleMedium
                                      .fontStyle,
                                  lineHeight: 1.4,
                                ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(1.0, 0.0),
                        child: Builder(
                          builder: (context) => InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return Dialog(
                                    elevation: 0,
                                    insetPadding: EdgeInsets.zero,
                                    backgroundColor: Colors.transparent,
                                    alignment: AlignmentDirectional(1.0, 0.0)
                                        .resolve(Directionality.of(context)),
                                    child: InventoryactionsWidget(
                                      inventoryID: widget.session_id,
                                    ),
                                  );
                                },
                              );
                            },
                            child: Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 24.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              valueOrDefault<String>(
                                widget.date,
                                'Oct 24, 2023 • 09:15 AM',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodySmall
                                  .override(
                                    font: GoogleFonts.ibmPlexSansArabic(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .fontStyle,
                                    ),
                                    color: Color(0xFFCCCCCC),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                    lineHeight: 1.4,
                                  ),
                            ),
                          ].divide(SizedBox(height: 4.0)),
                        ),
                      ),
                      wrapWithModel(
                        model: _model.statusBadgeModel,
                        updateCallback: () => safeSetState(() {}),
                        child: StatusBadgeWidget(
                          status: widget.status,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 16.0,
                    thickness: 1.0,
                    indent: 0.0,
                    endIndent: 0.0,
                    color: Color(0xFF444444),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      FFAppState().scannedTagList = [];
                      safeSetState(() {});
                      if (widget.status == 'in_progress') {
                        context.pushNamed(
                          RFIDScanningWidget.routeName,
                          queryParameters: {
                            'inventoryOrder': serializeParam(
                              widget.session_id,
                              ParamType.String,
                            ),
                          }.withoutNulls,
                        );
                      }
                    },
                    child: wrapWithModel(
                      model: _model.buttonModel,
                      updateCallback: () => safeSetState(() {}),
                      child: ButtonWidget(
                        content: 'Start Scan',
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.black,
                          size: 16.0,
                        ),
                        icon_present: true,
                        icon_end_present: false,
                        variant: 'ghost',
                        size: 'small',
                        full_width: false,
                        loading: false,
                        disabled: false,
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 16.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
