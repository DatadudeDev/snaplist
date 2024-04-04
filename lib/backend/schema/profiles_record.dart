import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProfilesRecord extends FirestoreRecord {
  ProfilesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "spotifyID" field.
  String? _spotifyID;
  String get spotifyID => _spotifyID ?? '';
  bool hasSpotifyID() => _spotifyID != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _spotifyID = snapshotData['spotifyID'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('profiles');

  static Stream<ProfilesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ProfilesRecord.fromSnapshot(s));

  static Future<ProfilesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ProfilesRecord.fromSnapshot(s));

  static ProfilesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ProfilesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ProfilesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ProfilesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ProfilesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ProfilesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createProfilesRecordData({
  DocumentReference? userRef,
  String? spotifyID,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'spotifyID': spotifyID,
    }.withoutNulls,
  );

  return firestoreData;
}

class ProfilesRecordDocumentEquality implements Equality<ProfilesRecord> {
  const ProfilesRecordDocumentEquality();

  @override
  bool equals(ProfilesRecord? e1, ProfilesRecord? e2) {
    return e1?.userRef == e2?.userRef && e1?.spotifyID == e2?.spotifyID;
  }

  @override
  int hash(ProfilesRecord? e) =>
      const ListEquality().hash([e?.userRef, e?.spotifyID]);

  @override
  bool isValidKey(Object? o) => o is ProfilesRecord;
}
