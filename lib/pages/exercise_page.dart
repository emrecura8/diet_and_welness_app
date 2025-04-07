import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/models/exercise_model.dart'; // Import Exercise model

class ExercisePage extends StatefulWidget {
  // Changed to StatefulWidget
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  // Placeholder list of exercises
  // TODO: Replace with actual data loading later
  final List<Exercise> _exercises = [
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

  // Function to show the exercise details dialog
  void _showExerciseDetails(BuildContext context, Exercise exercise) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(exercise.name),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Important for Column in AlertDialog
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(exercise.description),
                const SizedBox(height: 16),
                Text(
                  'How to Perform (Placeholder):',
                  style: Theme.of(
                    dialogContext,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Detailed step-by-step instructions, images, or a video link will be shown here in a future update.',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            // Match card theme rounding
            borderRadius: BorderRadius.circular(12.0),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Exercises')),
      backgroundColor:
          Theme.of(context).colorScheme.surface, // Use theme background
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0), // Add padding around the ListView
        itemCount: _exercises.length,
        itemBuilder: (context, index) {
          final exercise = _exercises[index];
          // Use Card defaults from Theme
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
              leading: const Icon(Icons.fitness_center_outlined),
              title: Text(
                exercise.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                exercise.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Chip(
                label: Text(exercise.category),
                labelStyle: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.secondary.withOpacity(0.1),
                padding: EdgeInsets.zero,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
              ),
              onTap: () {
                // Show the details dialog instead of SnackBar
                _showExerciseDetails(context, exercise);
              },
            ),
          );
        },
      ),
    );
  }
}
