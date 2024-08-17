import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'voice_modal_copy_model.dart';
export 'voice_modal_copy_model.dart';

class VoiceModalCopyWidget extends StatefulWidget {
  const VoiceModalCopyWidget({super.key});

  @override
  State<VoiceModalCopyWidget> createState() => _VoiceModalCopyWidgetState();
}

class _VoiceModalCopyWidgetState extends State<VoiceModalCopyWidget> {
  late VoiceModalCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => VoiceModalCopyModel());
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
      width: double.infinity,
      height: 150.0,
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
            child: Text(
              FFLocalizations.of(context).getText(
                'pu14wkqh' /* Godmode Portal */,
              ),
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
            child: PinCodeTextField(
              autoDisposeControllers: false,
              appContext: context,
              length: 6,
              textStyle: FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Readex Pro',
                    letterSpacing: 0.0,
                  ),
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              enableActiveFill: false,
              autoFocus: true,
              enablePinAutofill: false,
              errorTextSpace: 16.0,
              showCursor: true,
              cursorColor: FlutterFlowTheme.of(context).primary,
              obscureText: true,
              obscuringCharacter: '*',
              hintCharacter: '*',
              keyboardType: TextInputType.number,
              pinTheme: PinTheme(
                fieldHeight: 44.0,
                fieldWidth: 44.0,
                borderWidth: 2.0,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
                shape: PinCodeFieldShape.box,
                activeColor: FlutterFlowTheme.of(context).primaryText,
                inactiveColor: FlutterFlowTheme.of(context).alternate,
                selectedColor: FlutterFlowTheme.of(context).primary,
                activeFillColor: FlutterFlowTheme.of(context).primaryText,
                inactiveFillColor: FlutterFlowTheme.of(context).alternate,
                selectedFillColor: FlutterFlowTheme.of(context).primary,
              ),
              controller: _model.pinCodeController,
              onChanged: (_) {},
              onCompleted: (_) async {
                logFirebaseEvent('VOICE_MODAL_COPY_PinCode_j8xkynue_ON_PIN');
                if (_model.pinCodeController!.text == '209192') {
                  logFirebaseEvent('PinCode_update_app_state');
                  FFAppState().godmode = true;
                  setState(() {});
                  return;
                } else {
                  logFirebaseEvent('PinCode_show_snack_bar');
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'YOU SHALL NOT PASSSSSS!',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: const Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                  return;
                }
              },
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: _model.pinCodeControllerValidator.asValidator(context),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                FFLocalizations.of(context).getText(
                  '9ws971ff' /* STATUS: */,
                ),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Readex Pro',
                      letterSpacing: 0.0,
                    ),
              ),
              Stack(
                children: [
                  if (FFAppState().godmode == true)
                    Text(
                      FFLocalizations.of(context).getText(
                        '0v3imf0e' /*   ACTIVE */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: FlutterFlowTheme.of(context).success,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  if (FFAppState().godmode == false)
                    Text(
                      FFLocalizations.of(context).getText(
                        'es1tly3e' /*   INACTIVE */,
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Readex Pro',
                            color: FlutterFlowTheme.of(context).error,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
