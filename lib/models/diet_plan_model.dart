class DietPlan {
  final String id;
  final String name;
  final String description;
  final List<Map<String, dynamic>> meals;

  DietPlan({
    required this.id,
    required this.name,
    required this.description,
    this.meals = const [],
  });

  // Convert DietPlan object to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'description': description, 'meals': meals};
  }

  // Create DietPlan object from a Firestore Map
  factory DietPlan.fromMap(Map<String, dynamic> map) {
    return DietPlan(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      meals:
          (map['meals'] as List?)
              ?.map((e) => Map<String, dynamic>.from(e))
              .toList() ??
          [],
    );
  }
}
