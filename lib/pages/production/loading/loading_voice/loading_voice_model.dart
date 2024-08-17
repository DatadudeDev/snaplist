import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'loading_voice_widget.dart' show LoadingVoiceWidget;
import 'package:flutter/material.dart';

class LoadingVoiceModel extends FlutterFlowModel<LoadingVoiceWidget> {
  ///  Local state fields for this page.

  bool analyzingPhoto = false;

  bool generatingSceneDescription = false;

  bool generatingAlbumArt = false;

  bool namingPlaylist = false;

  bool uploadPhoto = true;

  bool wrappingUp = false;

  bool ten = false;

  bool twentyNine = false;

  bool thirtySeven = false;

  bool sixtyFive = false;

  bool eightyThree = false;

  bool oneHundred = false;

  bool fifty = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Post Voice)] action in loadingVoice widget.
  ApiCallResponse? sendVoice;
  // Stores action output result for [Backend Call - API (get Playlist URL)] action in loadingVoice widget.
  ApiCallResponse? getPlaylist;
  // Stores action output result for [Backend Call - API (start Player)] action in loadingVoice widget.
  ApiCallResponse? startPlayback;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
