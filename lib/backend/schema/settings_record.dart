import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';

class SettingsRecord extends FirestoreRecord {
  SettingsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "isEmailOK" field.
  bool? _isEmailOK;
  bool get isEmailOK => _isEmailOK ?? false;
  bool hasIsEmailOK() => _isEmailOK != null;

  // "isNotifyOK" field.
  bool? _isNotifyOK;
  bool get isNotifyOK => _isNotifyOK ?? false;
  bool hasIsNotifyOK() => _isNotifyOK != null;

  // "isDataOK" field.
  bool? _isDataOK;
  bool get isDataOK => _isDataOK ?? false;
  bool hasIsDataOK() => _isDataOK != null;

  // "createdOn" field.
  DateTime? _createdOn;
  DateTime? get createdOn => _createdOn;
  bool hasCreatedOn() => _createdOn != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _isEmailOK = snapshotData['isEmailOK'] as bool?;
    _isNotifyOK = snapshotData['isNotifyOK'] as bool?;
    _isDataOK = snapshotData['isDataOK'] as bool?;
    _createdOn = snapshotData['createdOn'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('settings');

  static Stream<SettingsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SettingsRecord.fromSnapshot(s));

  static Future<SettingsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SettingsRecord.fromSnapshot(s));

  static SettingsRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SettingsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SettingsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SettingsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SettingsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SettingsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSettingsRecordData({
  DocumentReference? user,
  bool? isEmailOK,
  bool? isNotifyOK,
  bool? isDataOK,
  DateTime? createdOn,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'isEmailOK': isEmailOK,
      'isNotifyOK': isNotifyOK,
      'isDataOK': isDataOK,
      'createdOn': createdOn,
    }.withoutNulls,
  );

  return firestoreData;
}

class SettingsRecordDocumentEquality implements Equality<SettingsRecord> {
  const SettingsRecordDocumentEquality();

  @override
  bool equals(SettingsRecord? e1, SettingsRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.isEmailOK == e2?.isEmailOK &&
        e1?.isNotifyOK == e2?.isNotifyOK &&
        e1?.isDataOK == e2?.isDataOK &&
        e1?.createdOn == e2?.createdOn;
  }

  @override
  int hash(SettingsRecord? e) => const ListEquality()
      .hash([e?.user, e?.isEmailOK, e?.isNotifyOK, e?.isDataOK, e?.createdOn]);

  @override
  bool isValidKey(Object? o) => o is SettingsRecord;
}
