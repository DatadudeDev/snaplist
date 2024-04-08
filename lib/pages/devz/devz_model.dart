import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'devz_widget.dart' show DevzWidget;
import 'package:flutter/material.dart';

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
