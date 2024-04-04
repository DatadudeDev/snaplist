import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'devz_widget.dart' show DevzWidget;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DevzModel extends FlutterFlowModel<DevzWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Stores action output result for [Backend Call - API (Recently played tracks)] action in devz widget.
  ApiCallResponse? tracks;
  // Stores action output result for [Firestore Query - Query a collection] action in devz widget.
  SongsRecord? lastPlayedTrack;
  // Stores action output result for [Custom Action - getDocUsingFilter] action in devz widget.
  SpotifyRecord? spotifyDocDev;
  // Stores action output result for [Backend Call - API (Acqurire New Access Token)] action in devz widget.
  ApiCallResponse? accessTokenResDev;
  // Stores action output result for [Backend Call - API (Get Profile)] action in devz widget.
  ApiCallResponse? tracks2;
  // Stores action output result for [Firestore Query - Query a collection] action in devz widget.
  SongsRecord? lastPlayedTrack2;
  // Stores action output result for [Backend Call - API (Get Playlist)] action in Button widget.
  ApiCallResponse? playlists;
  // Stores action output result for [Custom Action - getDocUsingFilter] action in Button widget.
  SpotifyRecord? spotifyDocDevCopy;
  // Stores action output result for [Backend Call - API (Acqurire New Access Token)] action in Button widget.
  ApiCallResponse? accessTokenResDevCopy;
  // Stores action output result for [Backend Call - API (Get Profile)] action in Button widget.
  ApiCallResponse? playlists2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
