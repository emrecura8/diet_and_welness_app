// Represents a user of the application
class User {
  final String id; // Unique ID (e.g., from Firebase Auth later)
  final String email;
  // Add other relevant user details later as needed
  // e.g., name, age, weight, fitnessGoal

  User({
    required this.id,
    required this.email,
    // Initialize other fields here
  });
}
