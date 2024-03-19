// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future updateOrInsertDocUsingFilter(
  String? fieldName1,
  String? fieldName2,
  String? fieldName3,
  String? fieldName4,
  String? fieldValue1,
  String? fieldValue2,
  String? fieldValue3,
  String? fieldValue4,
  String? collectionName,
) async {
  // null check
  fieldName1 ??= 'error';
  fieldName2 ??= 'error';
  fieldName3 ??= 'error';
  fieldName4 ??= 'error';
  fieldValue1 = fieldValue1 ?? '';
  fieldValue2 = fieldValue2 ?? '';
  fieldValue3 = fieldValue3 ?? '';
  fieldValue4 = fieldValue4 ?? '';
  collectionName = collectionName ?? '';

  // Get a reference to the Firestore database
  final firestore = FirebaseFirestore.instance;

  // Get a reference to the collection
  final collectionRef = firestore.collection(collectionName);

  DocumentReference userRef =
      FirebaseFirestore.instance.doc('/users' + fieldValue1);

  // new code
  final doc = {
    fieldName1: fieldValue1,
    fieldName2: fieldValue2,
    fieldName3: fieldValue3,
    fieldName1: fieldValue4,
  };

  // TODO: change fields you want to search for
  final docFilter =
      await collectionRef.where(fieldName1, isEqualTo: userRef).get();

  if (docFilter.docs.isNotEmpty) {
    // Update the existing document with the new data
    await docFilter.docs.first.reference.update(doc);
  } else {
    // Add a new document to the collection
    await collectionRef.add(doc);
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
