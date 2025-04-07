// Represents an exercise suggestion
class Exercise {
  final String id;
  final String name;
  final String description;
  final String category; // e.g., Cardio, Strength, Flexibility
  // Potentially add video link, image path, reps/duration later

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    // Initialize other fields
  });
}
