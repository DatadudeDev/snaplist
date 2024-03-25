import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'loading_widget.dart' show LoadingWidget;
import 'package:flutter/material.dart';

class LoadingModel extends FlutterFlowModel<LoadingWidget> {
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

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Send Uploaded Image Copy)] action in loading widget.
  ApiCallResponse? sendPhotoURL;
  // Stores action output result for [Backend Call - API (get Playlist URL)] action in loading widget.
  ApiCallResponse? getPlaylist;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
