import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/models/diet_plan_model.dart';
import 'package:provider/provider.dart';
import 'package:the_diet_and_welness_app/provider/diet_service.dart';

class DietPlanDetailPage extends StatelessWidget {
  final DietPlan dietPlan;

  const DietPlanDetailPage({super.key, required this.dietPlan});

  @override
  Widget build(BuildContext context) {
    final dietService = Provider.of<DietService>(context);
    final isFavorite = dietService.isFavoriteDiet(dietPlan.id);
    return Scaffold(
      appBar: AppBar(
        title: Text(dietPlan.name),
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder:
                (child, animation) =>
                    ScaleTransition(scale: animation, child: child),
            child: IconButton(
              key: ValueKey<bool>(isFavorite),
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.amber : Colors.grey,
              ),
              tooltip:
                  isFavorite ? 'Remove from favorites' : 'Add to favorites',
              onPressed: () async {
                await dietService.toggleFavoriteDiet(context, dietPlan.id);
                // Force rebuild to update icon
                (context as Element).markNeedsBuild();
              },
            ),
          ),
        ],
      ),
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
              'Sample Meals',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            if (dietPlan.meals.isNotEmpty)
              Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                child: Column(
                  children: [
                    for (int i = 0; i < dietPlan.meals.length; i++) ...[
                      ListTile(
                        leading: Icon(
                          Icons.local_dining,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(
                          '${dietPlan.meals[i]['type']}: ${dietPlan.meals[i]['name']}',
                        ),
                        subtitle: Text(
                          'Calories: ${dietPlan.meals[i]['calories']}',
                        ),
                      ),
                      if (i < dietPlan.meals.length - 1)
                        const Divider(height: 1, indent: 16, endIndent: 16),
                    ],
                  ],
                ),
              ),
            if (dietPlan.meals.isEmpty)
              const Text('No sample meals available.'),
          ],
        ),
      ),
    );
  }
}
