import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth; // Aliased import
import 'package:the_diet_and_welness_app/models/user_model.dart'
    as app_user; // Aliased import

class AuthService extends ChangeNotifier {
  final fb_auth.FirebaseAuth _firebaseAuth = fb_auth.FirebaseAuth.instance;
  app_user.User? _currentUser;

  app_user.User? get currentUser => _currentUser;

  AuthService() {
    // Listen to auth state changes
    _firebaseAuth.authStateChanges().listen((fb_auth.User? firebaseUser) {
      if (firebaseUser == null) {
        _currentUser = null;
        print('AuthService: User is currently signed out!');
      } else {
        // You might want to fetch more user details from Firestore here if needed
        _currentUser = app_user.User(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
        );
        print('AuthService: User is signed in: $firebaseUser.uid');
      }
      notifyListeners();
    });
  }

  Future<String?> loginUser(String email, String password) async {
    print('AuthService: Attempting Firebase login for $email');
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Auth state listener will update _currentUser and notify
      return null; // Success
    } on fb_auth.FirebaseAuthException catch (e) {
      print('Firebase login error: ${e.code} - ${e.message}');
      return e.message; // Return error message
    } catch (e) {
      print('Generic login error: $e');
      return 'An unexpected error occurred.';
    }
  }

  Future<String?> signupUser(String email, String password) async {
    print('AuthService: Attempting Firebase signup for $email');
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // Auth state listener will update _currentUser and notify
      // Optionally: save additional user info to Firestore here
      // if (fbUser != null) {
      //   await FirebaseFirestore.instance.collection('users').doc(fbUser.uid).set({
      //     'email': email,
      //     // Add other fields
      //   });
      // }
      return null; // Success
    } on fb_auth.FirebaseAuthException catch (e) {
      print('Firebase signup error: ${e.code} - ${e.message}');
      return e.message;
    } catch (e) {
      print('Generic signup error: $e');
      return 'An unexpected error occurred.';
    }
  }

  Future<void> logoutUser() async {
    print('AuthService: Logging out from Firebase');
    await _firebaseAuth.signOut();
    // Auth state listener will update _currentUser and notify
  }
}
