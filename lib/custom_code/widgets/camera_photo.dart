// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:camera/camera.dart';

class CameraPhoto extends StatefulWidget {
  const CameraPhoto({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _CameraPhotoState createState() => _CameraPhotoState();
}

class _CameraPhotoState extends State<CameraPhoto> {
  CameraController? controller;
  late Future<List<CameraDescription>> _cameras;

  @override
  void initState() {
    super.initState();
    _cameras = availableCameras();
    manageCameraState(); // Initial check and setup
  }

  // Added a method to manage the camera state based on 'cameraOn'
  void manageCameraState() {
    if (FFAppState().cameraOn) {
      _cameras.then((availableCameras) {
        if (availableCameras.isNotEmpty) {
          controller =
              CameraController(availableCameras[0], ResolutionPreset.max);
          controller!.initialize().then((_) {
            if (!mounted) {
              return;
            }
            setState(() {});
          });
        }
      });
    } else {
      controller?.dispose();
      controller =
          null; // Clear the controller since we're turning the camera off
    }
  }

  @override
  void didUpdateWidget(covariant CameraPhoto oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check for state changes to potentially turn on/off the camera
    manageCameraState();

    if (FFAppState().makePhoto && controller != null) {
      controller!.takePicture().then((file) async {
        Uint8List fileAsBytes = await file.readAsBytes();
        final base64 = base64Encode(fileAsBytes);

        FFAppState().update(() {
          FFAppState().fileBase64 = base64;
          FFAppState().makePhoto = false; // Reset after taking a photo
        });
      }).catchError((error) {});
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CameraDescription>>(
      future: _cameras,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            FFAppState().cameraOn) {
          if (snapshot.hasData &&
              snapshot.data!.isNotEmpty &&
              controller != null) {
            return controller!.value.isInitialized
                ? MaterialApp(
                    home: CameraPreview(controller!),
                  )
                : Container();
          } else {
            return Center(child: Text('No cameras available.'));
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
