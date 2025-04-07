import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/models/diet_plan_model.dart'; // Import DietPlan model

// Placeholder for managing diet plan data
class DietService extends ChangeNotifier {
  // Placeholder list of diet plans
  List<DietPlan> _dietPlans = [
    DietPlan(
      id: '1',
      name: 'Weight Loss Basic',
      description: 'A balanced plan focused on calorie deficit.',
    ),
    DietPlan(
      id: '2',
      name: 'Muscle Gain Starter',
      description: 'Higher protein intake for muscle growth.',
    ),
    DietPlan(
      id: '3',
      name: 'Healthy Maintenance',
      description: 'Focuses on balanced nutrition for maintaining weight.',
    ),
  ];

  List<DietPlan> get dietPlans => _dietPlans;

  // Placeholder method to fetch diet plans
  Future<void> fetchDietPlans() async {
    // TODO: Implement actual data fetching (e.g., from Firestore or local asset) later
    print('DietService: Fetching diet plans');
    await Future.delayed(const Duration(milliseconds: 600)); // Simulate loading
    // Use hardcoded list for now
    // notifyListeners(); // Only notify if data actually changes
  }

  // Placeholder method to get a specific diet plan by ID
  DietPlan? getDietPlanById(String id) {
    // TODO: Improve this if fetching data asynchronously
    try {
      return _dietPlans.firstWhere((plan) => plan.id == id);
    } catch (e) {
      return null; // Not found
    }
  }

  // Add methods for filtering or customizing plans later if needed
}
