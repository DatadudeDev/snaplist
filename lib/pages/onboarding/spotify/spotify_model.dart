import '/flutter_flow/flutter_flow_util.dart';
import 'spotify_widget.dart' show SpotifyWidget;
import 'package:flutter/material.dart';

class SpotifyModel extends FlutterFlowModel<SpotifyWidget> {
  ///  Local state fields for this page.

  bool sotifyAuth = true;

  String? redirectUrl;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
