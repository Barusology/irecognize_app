import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/identification.dart';

class IdentificationService {
  IdentificationService({FirebaseFirestore? firestore, FirebaseAuth? auth})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _entries {
    final user = _auth.currentUser;
    if (user == null) throw StateError('Sign in to access your archive.');
    return _firestore.collection('users').doc(user.uid).collection('identifications');
  }

  Stream<List<Identification>> watchEntries() => _entries
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Identification.fromMap(doc.id, doc.data())).toList());

  Future<String> save(Identification entry) async {
    final doc = entry.id.isEmpty ? _entries.doc() : _entries.doc(entry.id);
    await doc.set(entry.toMap());
    return doc.id;
  }
}
