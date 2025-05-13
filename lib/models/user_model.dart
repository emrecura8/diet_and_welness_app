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

  // Convert User object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      // Add other fields if they exist
    };
  }

  // Create User object from a Firestore Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      // Add other fields if they exist
    );
  }
}
