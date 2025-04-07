import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/models/diet_plan_model.dart';

class DietPlanDetailPage extends StatelessWidget {
  final DietPlan dietPlan;

  const DietPlanDetailPage({super.key, required this.dietPlan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(dietPlan.name)),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Plan Overview',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      dietPlan.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            Text(
              'Sample Meals (Placeholder)',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Card(
              elevation: 0,
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.local_dining,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Breakfast: Oatmeal with fruits'),
                    subtitle: const Text('Approx. 350 calories'),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Icon(
                      Icons.local_dining,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Lunch: Grilled Chicken Salad'),
                    subtitle: const Text('Approx. 450 calories'),
                  ),
                  const Divider(height: 1, indent: 16, endIndent: 16),
                  ListTile(
                    leading: Icon(
                      Icons.local_dining,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: const Text('Dinner: Salmon with Roasted Vegetables'),
                    subtitle: const Text('Approx. 500 calories'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
