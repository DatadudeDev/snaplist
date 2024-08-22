import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/production/components/input_modal/input_modal_widget.dart';
import '/pages/production/components/voice_modal/voice_modal_widget.dart';
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

  bool isPaused = false;

  int? currentIndex = 2;

  bool isPlacePicker = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (get Moods)] action in HomePage widget.
  ApiCallResponse? getMoods;
  // Stores action output result for [Backend Call - API (Acqurire New Access Token)] action in HomePage widget.
  ApiCallResponse? refreshAccessToken1;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  AuthRecord? getRefreshTokenFromFirebase;
  // Stores action output result for [Backend Call - API (Acqurire New Access Token)] action in HomePage widget.
  ApiCallResponse? refreshAccessToken2;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  PremiumRecord? checkPremium;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;

  // Model for inputModal component.
  late InputModalModel inputModalModel;
  // Model for voiceModal component.
  late VoiceModalModel voiceModalModel;
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // State field(s) for navCarousel widget.
  CarouselController? navCarouselController;
  int navCarouselCurrentIndex = 2;

  // Stores action output result for [Backend Call - API (Pause Music)] action in Voice widget.
  ApiCallResponse? apiPauseMusic;
  bool isDataUploading3 = false;
  FFUploadedFile uploadedLocalFile3 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  bool isDataUploading4 = false;
  FFUploadedFile uploadedLocalFile4 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  @override
  void initState(BuildContext context) {
    inputModalModel = createModel(context, () => InputModalModel());
    voiceModalModel = createModel(context, () => VoiceModalModel());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    inputModalModel.dispose();
    voiceModalModel.dispose();
  }
}
