import '/flutter_flow/flutter_flow_util.dart';
import 'voice_modal_widget.dart' show VoiceModalWidget;
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class VoiceModalModel extends FlutterFlowModel<VoiceModalWidget> {
  ///  Local state fields for this component.

  bool isBug = false;

  ///  State fields for stateful widgets in this component.

  AudioRecorder? audioRecorder;
  String? audio;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
