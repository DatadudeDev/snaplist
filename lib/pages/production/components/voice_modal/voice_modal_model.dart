import '/flutter_flow/flutter_flow_util.dart';
import 'voice_modal_widget.dart' show VoiceModalWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

class VoiceModalModel extends FlutterFlowModel<VoiceModalWidget> {
  ///  Local state fields for this component.

  bool isBug = false;

  ///  State fields for stateful widgets in this component.

  AudioRecorder? audioRecorder;
  String? stopAudioRecording;
  FFUploadedFile recordedFileBytes1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  // State field(s) for Carousel widget.
  CarouselController? carouselController;
  int carouselCurrentIndex = 0;

  String? audio;
  FFUploadedFile recordedFileBytes2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
