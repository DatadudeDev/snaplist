import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class AuthRecord extends FirestoreRecord {
  AuthRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "refresh_token" field.
  String? _refreshToken;
  String get refreshToken => _refreshToken ?? '';
  bool hasRefreshToken() => _refreshToken != null;

  // "access_token" field.
  String? _accessToken;
  String get accessToken => _accessToken ?? '';
  bool hasAccessToken() => _accessToken != null;

  // "timeCreated" field.
  DateTime? _timeCreated;
  DateTime? get timeCreated => _timeCreated;
  bool hasTimeCreated() => _timeCreated != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _refreshToken = snapshotData['refresh_token'] as String?;
    _accessToken = snapshotData['access_token'] as String?;
    _timeCreated = snapshotData['timeCreated'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('auth');

  static Stream<AuthRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => AuthRecord.fromSnapshot(s));

  static Future<AuthRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => AuthRecord.fromSnapshot(s));

  static AuthRecord fromSnapshot(DocumentSnapshot snapshot) => AuthRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static AuthRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      AuthRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'AuthRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is AuthRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createAuthRecordData({
  DocumentReference? user,
  String? refreshToken,
  String? accessToken,
  DateTime? timeCreated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'refresh_token': refreshToken,
      'access_token': accessToken,
      'timeCreated': timeCreated,
    }.withoutNulls,
  );

  return firestoreData;
}

class AuthRecordDocumentEquality implements Equality<AuthRecord> {
  const AuthRecordDocumentEquality();

  @override
  bool equals(AuthRecord? e1, AuthRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.refreshToken == e2?.refreshToken &&
        e1?.accessToken == e2?.accessToken &&
        e1?.timeCreated == e2?.timeCreated;
  }

  @override
  int hash(AuthRecord? e) => const ListEquality()
      .hash([e?.user, e?.refreshToken, e?.accessToken, e?.timeCreated]);

  @override
  bool isValidKey(Object? o) => o is AuthRecord;
}
