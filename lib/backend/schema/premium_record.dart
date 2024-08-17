import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class PremiumRecord extends FirestoreRecord {
  PremiumRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "isPremium" field.
  bool? _isPremium;
  bool get isPremium => _isPremium ?? false;
  bool hasIsPremium() => _isPremium != null;

  // "createdOn" field.
  DateTime? _createdOn;
  DateTime? get createdOn => _createdOn;
  bool hasCreatedOn() => _createdOn != null;

  void _initializeFields() {
    _user = snapshotData['user'] as DocumentReference?;
    _isPremium = snapshotData['isPremium'] as bool?;
    _createdOn = snapshotData['createdOn'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('premium');

  static Stream<PremiumRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => PremiumRecord.fromSnapshot(s));

  static Future<PremiumRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => PremiumRecord.fromSnapshot(s));

  static PremiumRecord fromSnapshot(DocumentSnapshot snapshot) =>
      PremiumRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static PremiumRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      PremiumRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'PremiumRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is PremiumRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createPremiumRecordData({
  DocumentReference? user,
  bool? isPremium,
  DateTime? createdOn,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'user': user,
      'isPremium': isPremium,
      'createdOn': createdOn,
    }.withoutNulls,
  );

  return firestoreData;
}

class PremiumRecordDocumentEquality implements Equality<PremiumRecord> {
  const PremiumRecordDocumentEquality();

  @override
  bool equals(PremiumRecord? e1, PremiumRecord? e2) {
    return e1?.user == e2?.user &&
        e1?.isPremium == e2?.isPremium &&
        e1?.createdOn == e2?.createdOn;
  }

  @override
  int hash(PremiumRecord? e) =>
      const ListEquality().hash([e?.user, e?.isPremium, e?.createdOn]);

  @override
  bool isValidKey(Object? o) => o is PremiumRecord;
}
