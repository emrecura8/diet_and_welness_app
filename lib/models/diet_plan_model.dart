// Represents a predefined diet plan
class DietPlan {
  final String id;
  final String name;
  final String description;
  // Potentially add a list of Meal objects later
  // List<Meal> meals;

  DietPlan({
    required this.id,
    required this.name,
    required this.description,
    // Initialize meals here if added
  });
}

// Example: Placeholder for a Meal within a diet plan
// class Meal {
//   final String name;
//   final String details; // e.g., ingredients, calories
//   Meal({required this.name, required this.details});
// }
