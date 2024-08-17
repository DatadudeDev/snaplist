import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'places_widget.dart' show PlacesWidget;
import 'package:flutter/material.dart';

class PlacesModel extends FlutterFlowModel<PlacesWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = const FFPlace();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
