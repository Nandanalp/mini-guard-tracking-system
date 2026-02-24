import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/guard_model.dart';
import '../models/booking_model.dart';

class GuardRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Save or update guard profile
  Future<void> saveGuardProfile(GuardModel guard) async {
    await _firestore.collection('guards').doc(guard.id).set(guard.toMap());
  }

  // Get guard profile
  Future<GuardModel?> getGuardProfile(String guardId) async {
    try {
      final doc = await _firestore.collection('guards').doc(guardId).get();
      if (doc.exists) {
        return GuardModel.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  // Update location - uses current user
  Future<void> updateLocation(double latitude, double longitude) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    
    await _firestore.collection('guards').doc(user.uid).update({
      'latitude': latitude,
      'longitude': longitude,
      'lastUpdated': DateTime.now().toIso8601String(),
    });
  }

  // Update availability - uses current user
  Future<void> updateAvailability(bool isOnline) async {
    User? user = _auth.currentUser;
    if (user == null) throw Exception('User not authenticated');
    
    await _firestore.collection('guards').doc(user.uid).update({
      'isOnline': isOnline,
    });
  }

  // Get bookings for guard - uses current user
  Stream<List<BookingModel>> getGuardBookings() {
    User? user = _auth.currentUser;
    if (user == null) return Stream.error(Exception('User not authenticated'));
    
    return _firestore
        .collection('bookings')
        .where('guardId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => BookingModel.fromMap(doc.data())).toList();
    });
  }

  // Accept booking
  Future<void> acceptBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'status': 'accepted',
      'acceptedAt': DateTime.now(),
    });
  }

  // Complete booking
  Future<void> completeBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'status': 'completed',
      'completedAt': DateTime.now(),
    });
  }

  // Reject booking
  Future<void> rejectBooking(String bookingId) async {
    await _firestore.collection('bookings').doc(bookingId).update({
      'status': 'cancelled',
    });
  }
}
