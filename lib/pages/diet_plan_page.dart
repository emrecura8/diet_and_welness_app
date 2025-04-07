import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/models/diet_plan_model.dart'; // Import DietPlan model
import 'package:the_diet_and_welness_app/pages/diet_plan_detail_page.dart'; // Import detail page

class DietPlanPage extends StatefulWidget {
  // Changed to StatefulWidget
  const DietPlanPage({super.key});

  @override
  State<DietPlanPage> createState() => _DietPlanPageState();
}

class _DietPlanPageState extends State<DietPlanPage> {
  // Placeholder list of diet plans
  // TODO: Replace with actual data loading later
  final List<DietPlan> _dietPlans = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Diet Plans')),
      backgroundColor:
          Theme.of(context).colorScheme.surface, // Use theme background
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0), // Add padding around the ListView
        itemCount: _dietPlans.length,
        itemBuilder: (context, index) {
          final plan = _dietPlans[index];
          // Use Card defaults from Theme
          return Card(
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 16.0,
              ),
              leading: const Icon(Icons.restaurant_menu_outlined),
              title: Text(
                plan.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                plan.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 18.0),
              onTap: () {
                // Navigate to detail page, passing the selected plan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DietPlanDetailPage(dietPlan: plan),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
