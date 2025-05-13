import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/models/exercise_model.dart'; // Import Exercise model
import 'package:provider/provider.dart';
import 'package:the_diet_and_welness_app/provider/exercise_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  bool _isLoading = true;
  bool _showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    _fetchExercises();
  }

  Future<void> _fetchExercises() async {
    final exerciseService = Provider.of<ExerciseService>(
      context,
      listen: false,
    );
    await exerciseService.fetchExercises(context);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
            borderRadius: BorderRadius.circular(12.0),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final exerciseService = Provider.of<ExerciseService>(context);
    final exercises = exerciseService.exercises;
    final favoriteIds = exerciseService.favoriteIds;
    final filteredExercises =
        _showFavoritesOnly
            ? exercises.where((ex) => favoriteIds.contains(ex.id)).toList()
            : exercises;
    return Scaffold(
      appBar: AppBar(title: const Text('Exercises')),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : exercises.isEmpty
              ? const Center(child: Text('No exercises found.'))
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FilterChip(
                          label: const Text('Show Favorites'),
                          selected: _showFavoritesOnly,
                          avatar: Icon(
                            Icons.star,
                            color:
                                _showFavoritesOnly ? Colors.amber : Colors.grey,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              _showFavoritesOnly = selected;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: filteredExercises.length,
                      itemBuilder: (context, index) {
                        final exercise = filteredExercises[index];
                        final isFavorite = favoriteIds.contains(exercise.id);
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0,
                            ),
                            leading: const Icon(Icons.fitness_center_outlined),
                            title: Text(
                              exercise.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              exercise.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Chip(
                                  label: Text(exercise.category),
                                  labelStyle: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.secondary.withOpacity(0.1),
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder:
                                      (child, animation) => ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                  child: IconButton(
                                    key: ValueKey<bool>(isFavorite),
                                    icon: Icon(
                                      isFavorite
                                          ? Icons.star
                                          : Icons.star_border,
                                      color:
                                          isFavorite
                                              ? Colors.amber
                                              : Colors.grey,
                                    ),
                                    tooltip:
                                        isFavorite
                                            ? 'Remove from favorites'
                                            : 'Add to favorites',
                                    onPressed: () async {
                                      await exerciseService.toggleFavorite(
                                        context,
                                        exercise.id,
                                      );
                                      setState(() {}); // Update UI immediately
                                    },
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              _showExerciseDetails(context, exercise);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.open_in_new),
                      label: const Text('Reference: musclewiki.com'),
                      onPressed: () async {
                        final url = Uri.parse('https://musclewiki.com/');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
