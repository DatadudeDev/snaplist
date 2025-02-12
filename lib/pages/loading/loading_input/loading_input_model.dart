import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'loading_input_widget.dart' show LoadingInputWidget;
import 'package:flutter/material.dart';

class LoadingInputModel extends FlutterFlowModel<LoadingInputWidget> {
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

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Post Input)] action in loadingInput widget.
  ApiCallResponse? sendPhotoURLLoading;
  // Stores action output result for [Backend Call - API (get Playlist URL Input)] action in loadingInput widget.
  ApiCallResponse? getPlaylist;
  // Stores action output result for [Backend Call - API (start Player)] action in loadingInput widget.
  ApiCallResponse? startPlayback;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
