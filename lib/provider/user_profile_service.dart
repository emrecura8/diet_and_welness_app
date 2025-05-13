import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_diet_and_welness_app/db/local_db.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Placeholder for managing user profile data (e.g., Firestore/SQLite)
class UserProfileService extends ChangeNotifier {
  // Placeholder user profile data
  // TODO: Replace with actual data model and loading
  Map<String, dynamic> _userProfile = {
    'name': '',
    'age': 25,
    'weight': 70.0,
    'height': 175.0,
    'bmi': null,
    'goal': 'Weight Loss',
  };

  Map<String, dynamic> get userProfile => _userProfile;

  // Placeholder method to fetch user profile
  Future<void> fetchUserProfile(String userId) async {
    print('UserProfileService: Fetching profile for user $userId');
    try {
      // Try Firestore first
      final doc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('profile')
              .doc('main')
              .get();
      if (doc.exists) {
        _userProfile = {
          'name': doc.data()!['name'] ?? '',
          'age': doc.data()!['age'] ?? 25,
          'weight': doc.data()!['weight'] ?? 70.0,
          'height': doc.data()!['height'] ?? 175.0,
          'bmi': doc.data()!['bmi'],
          'goal': doc.data()!['goal'] ?? 'Weight Loss',
        };
        // Save to SQLite for offline use (non-web only)
        if (!kIsWeb) {
          await LocalDB().saveUserProfile(userId, _userProfile);
        }
        notifyListeners();
        return;
      }
    } catch (e) {
      print('Firestore fetch failed, trying SQLite: $e');
    }
    // Fallback to SQLite (non-web only)
    if (!kIsWeb) {
      final localProfile = await LocalDB().getUserProfile(userId);
      if (localProfile != null) {
        _userProfile = {
          'name': localProfile['name'] ?? '',
          'age': localProfile['age'] ?? 25,
          'weight': localProfile['weight'] ?? 70.0,
          'height': localProfile['height'] ?? 175.0,
          'bmi': localProfile['bmi'],
          'goal': localProfile['goal'] ?? 'Weight Loss',
        };
        notifyListeners();
      }
    }
  }

  // Placeholder method to update user profile
  Future<bool> updateUserProfile(
    String userId,
    Map<String, dynamic> updatedData,
  ) async {
    print(
      'UserProfileService: Updating profile for user $userId with data: $updatedData',
    );
    _userProfile.addAll(updatedData);
    notifyListeners();
    try {
      // Save to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('profile')
          .doc('main')
          .set(_userProfile);
    } catch (e) {
      print('Error saving profile to Firestore: $e');
    }
    // Always save to SQLite (non-web only)
    if (!kIsWeb) {
      await LocalDB().saveUserProfile(userId, _userProfile);
    }
    return true;
  }
}
