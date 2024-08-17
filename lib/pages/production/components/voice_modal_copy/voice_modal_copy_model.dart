import '/flutter_flow/flutter_flow_util.dart';
import 'voice_modal_copy_widget.dart' show VoiceModalCopyWidget;
import 'package:flutter/material.dart';

class VoiceModalCopyModel extends FlutterFlowModel<VoiceModalCopyWidget> {
  ///  Local state fields for this component.

  bool isBug = false;

  bool isPaused = false;

  ///  State fields for stateful widgets in this component.

  // State field(s) for PinCode widget.
  TextEditingController? pinCodeController;
  String? Function(BuildContext, String?)? pinCodeControllerValidator;

  @override
  void initState(BuildContext context) {
    pinCodeController = TextEditingController();
  }

  @override
  void dispose() {
    pinCodeController?.dispose();
  }
}
