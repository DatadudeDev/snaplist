import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SnaplistsRecord extends FirestoreRecord {
  SnaplistsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "image_url" field.
  String? _imageUrl;
  String get imageUrl => _imageUrl ?? '';
  bool hasImageUrl() => _imageUrl != null;

  // "createdTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "url" field.
  String? _url;
  String get url => _url ?? '';
  bool hasUrl() => _url != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  bool hasId() => _id != null;

  void _initializeFields() {
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _name = snapshotData['name'] as String?;
    _description = snapshotData['description'] as String?;
    _imageUrl = snapshotData['image_url'] as String?;
    _createdTime = snapshotData['createdTime'] as DateTime?;
    _url = snapshotData['url'] as String?;
    _id = snapshotData['id'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('snaplists');

  static Stream<SnaplistsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SnaplistsRecord.fromSnapshot(s));

  static Future<SnaplistsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SnaplistsRecord.fromSnapshot(s));

  static SnaplistsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SnaplistsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SnaplistsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SnaplistsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SnaplistsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SnaplistsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSnaplistsRecordData({
  DocumentReference? userRef,
  String? name,
  String? description,
  String? imageUrl,
  DateTime? createdTime,
  String? url,
  String? id,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userRef': userRef,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'createdTime': createdTime,
      'url': url,
      'id': id,
    }.withoutNulls,
  );

  return firestoreData;
}

class SnaplistsRecordDocumentEquality implements Equality<SnaplistsRecord> {
  const SnaplistsRecordDocumentEquality();

  @override
  bool equals(SnaplistsRecord? e1, SnaplistsRecord? e2) {
    return e1?.userRef == e2?.userRef &&
        e1?.name == e2?.name &&
        e1?.description == e2?.description &&
        e1?.imageUrl == e2?.imageUrl &&
        e1?.createdTime == e2?.createdTime &&
        e1?.url == e2?.url &&
        e1?.id == e2?.id;
  }

  @override
  int hash(SnaplistsRecord? e) => const ListEquality().hash([
        e?.userRef,
        e?.name,
        e?.description,
        e?.imageUrl,
        e?.createdTime,
        e?.url,
        e?.id
      ]);

  @override
  bool isValidKey(Object? o) => o is SnaplistsRecord;
}
