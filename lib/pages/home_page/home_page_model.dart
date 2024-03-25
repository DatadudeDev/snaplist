import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'home_page_widget.dart' show HomePageWidget;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  Local state fields for this page.

  bool isMenu = false;

  bool isPhotoTaken = false;

  String? playlistUrl;

  bool isSettings = false;

  bool isProfile = false;

  bool isRecents = false;

  bool isFeedback = false;

  bool isExplore = false;

  bool isLeftHanded = false;

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (get Moods)] action in HomePage widget.
  ApiCallResponse? getMoods;
  // Stores action output result for [Backend Call - API (Get Playlists)] action in HomePage widget.
  ApiCallResponse? getPlaylists;
  // Stores action output result for [Custom Action - getDocUsingFilter] action in HomePage widget.
  SpotifyRecord? spotifyDocDev;
  // Stores action output result for [Backend Call - API (Access Token)] action in HomePage widget.
  ApiCallResponse? accessTokenResDev;
  // Stores action output result for [Backend Call - API (Get Playlists)] action in HomePage widget.
  ApiCallResponse? getPlaylist2;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  SongsRecord? lastPlayedTrack2;
  // State field(s) for Carousel widget.
  CarouselController? carouselController;

  int carouselCurrentIndex = 2;

  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
