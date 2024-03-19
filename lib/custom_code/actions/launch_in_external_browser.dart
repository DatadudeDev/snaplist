// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:url_launcher/url_launcher.dart';
// End of FlutterFlow imports

Future<void> launchInExternalBrowser(String urlString) async {
  final Uri uri = Uri.parse(urlString);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}
