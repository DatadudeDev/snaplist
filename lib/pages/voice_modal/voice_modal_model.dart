import '/backend/api_requests/api_calls.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:async';
import 'voice_modal_widget.dart' show VoiceModalWidget;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';

class VoiceModalModel extends FlutterFlowModel<VoiceModalWidget> {
  ///  Local state fields for this component.

  bool isBug = false;

  bool isPaused = false;

  ///  State fields for stateful widgets in this component.

  AudioRecorder? audioRecorder;
  String? audio;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - API (Resume Music)] action in Container widget.
  ApiCallResponse? apiResult2c4;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
