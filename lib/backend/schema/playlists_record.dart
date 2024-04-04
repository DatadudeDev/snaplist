import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PlaylistsRecord extends FirestoreRecord {
  PlaylistsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('playlists');

  static Stream<PlaylistsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PlaylistsRecord.fromSnapshot(s));

  static Future<PlaylistsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PlaylistsRecord.fromSnapshot(s));

  static PlaylistsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PlaylistsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PlaylistsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PlaylistsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PlaylistsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PlaylistsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPlaylistsRecordData({
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class PlaylistsRecordDocumentEquality implements Equality<PlaylistsRecord> {
  const PlaylistsRecordDocumentEquality();

  @override
  bool equals(PlaylistsRecord? e1, PlaylistsRecord? e2) {
    return e1?.userRef == e2?.userRef;
  }

  @override
  int hash(PlaylistsRecord? e) => const ListEquality().hash([e?.userRef]);

  @override
  bool isValidKey(Object? o) => o is PlaylistsRecord;
}
