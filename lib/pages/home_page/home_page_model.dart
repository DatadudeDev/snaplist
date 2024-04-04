import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/pages/feedback_modal/feedback_modal_widget.dart';
import '/pages/input_modal/input_modal_widget.dart';
import '/pages/voice_modal/voice_modal_widget.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import 'home_page_widget.dart' show HomePageWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

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

  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (get Moods)] action in HomePage widget.
  ApiCallResponse? getMoods;
  // Stores action output result for [Backend Call - API (Acqurire New Access Token)] action in HomePage widget.
  ApiCallResponse? refreshAccessToken1;
  // Stores action output result for [Firestore Query - Query a collection] action in HomePage widget.
  AuthRecord? getRefreshTokenFromFirebase;
  // Stores action output result for [Backend Call - API (Acqurire New Access Token)] action in HomePage widget.
  ApiCallResponse? refreshAccessToken2;
  // State field(s) for Carousel widget.
  CarouselController? carouselController;

  int carouselCurrentIndex = 2;

  // Stores action output result for [Backend Call - API (Pause Music)] action in IconButton widget.
  ApiCallResponse? pauseMusic;
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
    tabBarController?.dispose();
  }
}
