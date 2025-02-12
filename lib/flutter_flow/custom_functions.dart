import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

FFUploadedFile? base64toFile(String base64Img) {
  final bytes = base64Decode(base64Img);
  final file = FFUploadedFile(bytes: bytes);
  return file;
}

FFUploadedFile? base64toFileCopy(String base64Img) {
  final bytes = base64Decode(base64Img);
  final file = FFUploadedFile(bytes: bytes, name: 'photo.jpeg');
  return file;
}

String? toBase64(String? input) {
  // null safety
  input ??= '';

  var bytes = utf8.encode(input);
  return base64.encode(bytes);
}
