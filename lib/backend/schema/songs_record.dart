import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SongsRecord extends FirestoreRecord {
  SongsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "artist" field.
  String? _artist;
  String get artist => _artist ?? '';
  bool hasArtist() => _artist != null;

  // "playedTime" field.
  DateTime? _playedTime;
  DateTime? get playedTime => _playedTime;
  bool hasPlayedTime() => _playedTime != null;

  // "album" field.
  String? _album;
  String get album => _album ?? '';
  bool hasAlbum() => _album != null;

  // "albumCover" field.
  String? _albumCover;
  String get albumCover => _albumCover ?? '';
  bool hasAlbumCover() => _albumCover != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _artist = snapshotData['artist'] as String?;
    _playedTime = snapshotData['playedTime'] as DateTime?;
    _album = snapshotData['album'] as String?;
    _albumCover = snapshotData['albumCover'] as String?;
    _userRef = snapshotData['userRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('songs');

  static Stream<SongsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SongsRecord.fromSnapshot(s));

  static Future<SongsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SongsRecord.fromSnapshot(s));

  static SongsRecord fromSnapshot(DocumentSnapshot snapshot) => SongsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SongsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SongsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SongsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SongsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSongsRecordData({
  String? title,
  String? artist,
  DateTime? playedTime,
  String? album,
  String? albumCover,
  DocumentReference? userRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'artist': artist,
      'playedTime': playedTime,
      'album': album,
      'albumCover': albumCover,
      'userRef': userRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class SongsRecordDocumentEquality implements Equality<SongsRecord> {
  const SongsRecordDocumentEquality();

  @override
  bool equals(SongsRecord? e1, SongsRecord? e2) {
    return e1?.title == e2?.title &&
        e1?.artist == e2?.artist &&
        e1?.playedTime == e2?.playedTime &&
        e1?.album == e2?.album &&
        e1?.albumCover == e2?.albumCover &&
        e1?.userRef == e2?.userRef;
  }

  @override
  int hash(SongsRecord? e) => const ListEquality().hash([
        e?.title,
        e?.artist,
        e?.playedTime,
        e?.album,
        e?.albumCover,
        e?.userRef
      ]);

  @override
  bool isValidKey(Object? o) => o is SongsRecord;
}
