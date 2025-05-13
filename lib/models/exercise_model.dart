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

  // Convert Exercise object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
    };
  }

  // Create Exercise object from a Firestore Map
  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
    );
  }
}
