// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<SpotifyRecord> getDocUsingFilter(
  String? fieldSearch,
  String? fieldValue,
  String? collectionName,
) async {
  // null check
  fieldSearch ??= 'error';
  fieldValue = fieldValue ?? '';
  collectionName = collectionName ?? '';
  // SpotifyRecord spotifyRec = createSpotifyRecordData(
  //     userRef: FirebaseFirestore.instance.doc('/spotify/123')) as SpotifyRecord;

  DocumentReference userRef =
      FirebaseFirestore.instance.doc('/users/' + fieldValue);

  final data = createSpotifyRecordData(
    userRef: FirebaseFirestore.instance.doc('/spotify/123'),
  );
  final docRef =
      FirebaseFirestore.instance.collection('spotify').doc('randomID');
  SpotifyRecord spotifyDoc = SpotifyRecord.getDocumentFromData(data, docRef);

  // Get a reference to the Firestore database
  final firestore = FirebaseFirestore.instance;

  // Get a reference to the collection
  final collectionRef = firestore.collection(collectionName);

  // Get the documents
  final querySnapshot =
      await collectionRef.where(fieldSearch, isEqualTo: userRef).get();

  // Return the first document if available, else return null
  SpotifyRecord response = querySnapshot.docs.isNotEmpty
      ? SpotifyRecord.fromSnapshot(querySnapshot.docs[0])
      : spotifyDoc;

  print(['SpotifyDoc', response, userRef]);

  return response;
}

// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
