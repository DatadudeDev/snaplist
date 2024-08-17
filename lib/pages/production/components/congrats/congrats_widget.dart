import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'congrats_model.dart';
export 'congrats_model.dart';

class CongratsWidget extends StatefulWidget {
  const CongratsWidget({super.key});

  @override
  State<CongratsWidget> createState() => _CongratsWidgetState();
}

class _CongratsWidgetState extends State<CongratsWidget> {
  late CongratsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CongratsModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: 350.0,
      height: 500.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: Image.asset(
            'assets/images/IMG_0279-1712607707518.gif',
          ).image,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
        border: Border.all(
          color: FlutterFlowTheme.of(context).primaryText,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xB014181B),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        FFLocalizations.of(context).getText(
                          'egbem50d' /* Congratulations! */,
                        ),
                        style:
                            FlutterFlowTheme.of(context).headlineLarge.override(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(12.0, 5.0, 0.0, 0.0),
                        child: Text(
                          FFLocalizations.of(context).getText(
                            '9xo4v3ew' /* You have successfully upgraded... */,
                          ),
                          textAlign: TextAlign.center,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'assets/images/IMG_0271-1712557987384.gif',
                width: 250.0,
                height: 250.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
              child: FFButtonWidget(
                onPressed: () async {
                  logFirebaseEvent('CONGRATS_COMP_CLOSE_BTN_ON_TAP');
                  logFirebaseEvent('Button_bottom_sheet');
                  Navigator.pop(context);
                },
                text: FFLocalizations.of(context).getText(
                  '4ybtnlbj' /* Close */,
                ),
                options: FFButtonOptions(
                  width: 160.0,
                  height: 50.0,
                  padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  iconPadding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  color: FFAppState().accentColor ?? FlutterFlowTheme.of(context).primary,
                  textStyle: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        letterSpacing: 0.0,
                      ),
                  elevation: 2.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
