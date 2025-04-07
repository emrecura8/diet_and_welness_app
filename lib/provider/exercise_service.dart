import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/models/exercise_model.dart'; // Import Exercise model

// Placeholder for managing exercise data
class ExerciseService extends ChangeNotifier {
  // Placeholder list of exercises
  List<Exercise> _exercises = [
    Exercise(
      id: '1',
      name: 'Push-ups',
      description:
          'Classic bodyweight exercise for chest, shoulders, and triceps.',
      category: 'Strength',
    ),
    Exercise(
      id: '2',
      name: 'Jogging',
      description: 'Cardiovascular exercise to improve endurance.',
      category: 'Cardio',
    ),
    Exercise(
      id: '3',
      name: 'Plank',
      description: 'Core strengthening exercise.',
      category: 'Strength',
    ),
    Exercise(
      id: '4',
      name: 'Lunges',
      description: 'Lower body exercise targeting quads and glutes.',
      category: 'Strength',
    ),
    Exercise(
      id: '5',
      name: 'Stretching',
      description: 'Basic stretches for flexibility.',
      category: 'Flexibility',
    ),
  ];

  List<Exercise> get exercises => _exercises;

  // Placeholder method to fetch exercises
  Future<void> fetchExercises() async {
    // TODO: Implement actual data fetching (e.g., from Firestore or local asset) later
    print('ExerciseService Fetching exercises');
    await Future.delayed(const Duration(milliseconds: 550)); // Simulate loading
    // Use hardcoded list for now
    // notifyListeners(); // Only notify if data actually changes
  }

  // Placeholder method to get exercises by category
  List<Exercise> getExercisesByCategory(String category) {
    // TODO: Improve this if fetching data asynchronously
    return _exercises
        .where((ex) => ex.category.toLowerCase() == category.toLowerCase())
        .toList();
  }

  // Add methods for searching or getting specific exercises later if needed
}
