import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'loading_image_widget.dart' show LoadingImageWidget;
import 'package:flutter/material.dart';

class LoadingImageModel extends FlutterFlowModel<LoadingImageWidget> {
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

  bool gotPlaylistURL = false;

  bool countdownFive = false;

  bool countdownFour = false;

  bool countdownThree = false;

  bool countdownTwo = false;

  bool countdownOne = false;

  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // Stores action output result for [Backend Call - API (Post Photo Dev)] action in loadingImage widget.
  ApiCallResponse? sendPhotoURLGod;
  // Stores action output result for [Backend Call - API (get Playlist URL)] action in loadingImage widget.
  ApiCallResponse? getPlaylistGod;
  // Stores action output result for [Backend Call - API (start Player)] action in loadingImage widget.
  ApiCallResponse? startPlaybackGod;
  // Stores action output result for [Backend Call - API (Send Uploaded Image Copy)] action in loadingImage widget.
  ApiCallResponse? sendPhotoURL;
  // Stores action output result for [Backend Call - API (get Playlist URL)] action in loadingImage widget.
  ApiCallResponse? getPlaylist;
  // Stores action output result for [Backend Call - API (start Player)] action in loadingImage widget.
  ApiCallResponse? startPlayback;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
