import '/flutter_flow/flutter_flow_place_picker.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'places_modal_model.dart';
export 'places_modal_model.dart';

class PlacesModalWidget extends StatefulWidget {
  const PlacesModalWidget({super.key});

  @override
  State<PlacesModalWidget> createState() => _PlacesModalWidgetState();
}

class _PlacesModalWidgetState extends State<PlacesModalWidget> {
  late PlacesModalModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PlacesModalModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlutterFlowPlacePicker(
            iOSGoogleMapsApiKey: 'AIzaSyBBzVycKke2mKHYdJlxidz4TDgmco1tW98',
            androidGoogleMapsApiKey: 'AIzaSyBBzVycKke2mKHYdJlxidz4TDgmco1tW98',
            webGoogleMapsApiKey: 'AIzaSyBBzVycKke2mKHYdJlxidz4TDgmco1tW98',
            onSelect: (place) async {
              setState(() => _model.placePickerValue = place);
            },
            defaultText: FFLocalizations.of(context).getText(
              '8lb92u9m' /* Select Location */,
            ),
            icon: Icon(
              Icons.place,
              color: FlutterFlowTheme.of(context).info,
              size: 16.0,
            ),
            buttonOptions: FFButtonOptions(
              width: 200.0,
              height: 40.0,
              color: FlutterFlowTheme.of(context).primary,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'Readex Pro',
                    color: FlutterFlowTheme.of(context).info,
                    letterSpacing: 0.0,
                  ),
              elevation: 2.0,
              borderSide: const BorderSide(
                color: Colors.transparent,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ],
      ),
    );
  }
}
