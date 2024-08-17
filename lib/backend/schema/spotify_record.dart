import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SpotifyRecord extends FirestoreRecord {
  SpotifyRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "refreshToken" field.
  String? _refreshToken;
  String get refreshToken => _refreshToken ?? '';
  bool hasRefreshToken() => _refreshToken != null;

  // "accessToken" field.
  String? _accessToken;
  String get accessToken => _accessToken ?? '';
  bool hasAccessToken() => _accessToken != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "authCode" field.
  String? _authCode;
  String get authCode => _authCode ?? '';
  bool hasAuthCode() => _authCode != null;

  void _initializeFields() {
    _refreshToken = snapshotData['refreshToken'] as String?;
    _accessToken = snapshotData['accessToken'] as String?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _authCode = snapshotData['authCode'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('spotify');

  static Stream<SpotifyRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SpotifyRecord.fromSnapshot(s));

  static Future<SpotifyRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SpotifyRecord.fromSnapshot(s));

  static SpotifyRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SpotifyRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SpotifyRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SpotifyRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SpotifyRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SpotifyRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSpotifyRecordData({
  String? refreshToken,
  String? accessToken,
  DocumentReference? userRef,
  String? authCode,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'refreshToken': refreshToken,
      'accessToken': accessToken,
      'userRef': userRef,
      'authCode': authCode,
    }.withoutNulls,
  );

  return firestoreData;
}

class SpotifyRecordDocumentEquality implements Equality<SpotifyRecord> {
  const SpotifyRecordDocumentEquality();

  @override
  bool equals(SpotifyRecord? e1, SpotifyRecord? e2) {
    return e1?.refreshToken == e2?.refreshToken &&
        e1?.accessToken == e2?.accessToken &&
        e1?.userRef == e2?.userRef &&
        e1?.authCode == e2?.authCode;
  }

  @override
  int hash(SpotifyRecord? e) => const ListEquality()
      .hash([e?.refreshToken, e?.accessToken, e?.userRef, e?.authCode]);

  @override
  bool isValidKey(Object? o) => o is SpotifyRecord;
}
