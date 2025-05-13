import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_diet_and_welness_app/models/exercise_model.dart';
import 'package:provider/provider.dart';
import 'package:the_diet_and_welness_app/provider/auth_service.dart';

// Placeholder for managing exercise data
class ExerciseService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Exercise> _exercises =
      []; // Initialize as empty, will be fetched from Firestore
  List<String> _favoriteIds = [];

  List<Exercise> get exercises => _exercises;
  List<String> get favoriteIds => _favoriteIds;
  List<Exercise> get favoriteExercises =>
      _exercises.where((ex) => _favoriteIds.contains(ex.id)).toList();

  // Placeholder method to fetch exercises
  Future<void> fetchExercises(BuildContext context) async {
    print('ExerciseService: Fetching exercises from Firestore');
    try {
      final snapshot = await _firestore.collection('exercises').get();
      _exercises =
          snapshot.docs.map((doc) {
            final data = doc.data();
            return Exercise(
              id: doc.id, // Use Firestore document ID
              name: data['name'] ?? '',
              description: data['description'] ?? '',
              category: data['category'] ?? '',
            );
          }).toList();
      print('ExerciseService: Fetched ${_exercises.length} exercises');
    } catch (e) {
      print('Error fetching exercises from Firestore: $e');
    }
    await fetchFavorites(context);
    notifyListeners(); // Notify listeners after data is fetched
  }

  Future<void> addExercise(BuildContext context, Exercise exercise) async {
    print('ExerciseService: Adding exercise to Firestore');
    try {
      // Add the exercise and let Firestore generate the ID
      DocumentReference docRef = await _firestore
          .collection('exercises')
          .add(exercise.toMap());
      // Optionally, update the exercise object with the Firestore-generated ID
      // Exercise addedExercise = Exercise.fromMap(exercise.toMap()..['id'] = docRef.id);
      // Then add to local list or refetch
      await fetchExercises(context);
      print('ExerciseService: Exercise added with ID: ${docRef.id}');
    } catch (e) {
      print('Error adding exercise: $e');
      // Handle error appropriately
    }
  }

  // Placeholder method to get exercises by category
  List<Exercise> getExercisesByCategory(String category) {
    // TODO: Improve this if fetching data asynchronously
    return _exercises
        .where((ex) => ex.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // --- Cloud Favorites ---
  Future<void> fetchFavorites(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    if (user == null) {
      _favoriteIds = [];
      return;
    }
    final favSnapshot =
        await _firestore
            .collection('users')
            .doc(user.id)
            .collection('favorites')
            .get();
    _favoriteIds = favSnapshot.docs.map((doc) => doc.id).toList();
  }

  Future<void> toggleFavorite(BuildContext context, String exerciseId) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final user = authService.currentUser;
    if (user == null) return;
    final favRef = _firestore
        .collection('users')
        .doc(user.id)
        .collection('favorites')
        .doc(exerciseId);
    final isFav = _favoriteIds.contains(exerciseId);
    if (isFav) {
      await favRef.delete();
      _favoriteIds.remove(exerciseId);
    } else {
      await favRef.set({'createdAt': FieldValue.serverTimestamp()});
      _favoriteIds.add(exerciseId);
    }
    notifyListeners();
  }

  bool isFavorite(String exerciseId) {
    return _favoriteIds.contains(exerciseId);
  }
}
