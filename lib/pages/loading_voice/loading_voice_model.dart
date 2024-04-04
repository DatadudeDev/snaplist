import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:async';
import 'loading_voice_widget.dart' show LoadingVoiceWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

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

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Post Voice)] action in loadingVoice widget.
  ApiCallResponse? sendVoice;
  // Stores action output result for [Backend Call - API (get Playlist URL)] action in loadingVoice widget.
  ApiCallResponse? getPlaylist;
  // Stores action output result for [Backend Call - API (start Player)] action in loadingVoice widget.
  ApiCallResponse? startPlayback;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
