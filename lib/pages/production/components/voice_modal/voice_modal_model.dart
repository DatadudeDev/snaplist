import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'voice_modal_widget.dart' show VoiceModalWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';

class VoiceModalModel extends FlutterFlowModel<VoiceModalWidget> {
  ///  Local state fields for this component.

  bool isBug = false;

  bool isPaused = false;

  ///  State fields for stateful widgets in this component.

  AudioPlayer? soundPlayer1;
  AudioRecorder? audioRecorder;
  AudioPlayer? soundPlayer2;
  String? audio;
  FFUploadedFile recordedFileBytes =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - API (Resume Music)] action in Container widget.
  ApiCallResponse? apiResult2c4;
  // State field(s) for Carousel widget.
  CarouselController? carouselController;
  int carouselCurrentIndex = 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
