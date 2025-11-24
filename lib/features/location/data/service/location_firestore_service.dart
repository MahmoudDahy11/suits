import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:suits/features/location/data/models/location_model.dart';

class LocationFirestoreService {
  final FirebaseFirestore firestore;
  LocationFirestoreService({required this.firestore});
  CollectionReference<Map<String, dynamic>> get _locationsCollection {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      throw Exception('User must be authenticated to access Locations.');
    }
    return firestore
        .collection('users')
        .doc(currentUser.uid)
        .collection('location');
  }

  Future<void> addLocation(LocationModel locationData) async {
    await _locationsCollection.add(locationData.toJson());
  }

  Future<List<LocationModel>> getLocations() async {
    final snapshot = await _locationsCollection.get();
    return snapshot.docs
        .map((doc) => LocationModel.fromJson(doc.data()))
        .toList();
  }

  Future<void> deleteLocation(String locationId) async {
    final snapshot = await _locationsCollection.get();
    for (final doc in snapshot.docs) {
      if (doc.data()['id'] == locationId) {
        await doc.reference.delete();
        break;
      }
    }
  }

  Future<void> updateLocation(LocationModel locationData) async {
    final snapshot = await _locationsCollection.get();
    for (final doc in snapshot.docs) {
      if (doc.data()['id'] == locationData.id) {
        await doc.reference.update(locationData.toJson());
        break;
      }
    }
  }
}
