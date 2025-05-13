import 'package:flutter/material.dart';
import 'package:the_diet_and_welness_app/models/diet_plan_model.dart'; // Import DietPlan model
import 'package:the_diet_and_welness_app/pages/diet_plan_detail_page.dart'; // Import detail page
import 'package:provider/provider.dart';
import 'package:the_diet_and_welness_app/provider/diet_service.dart';

class DietPlanPage extends StatefulWidget {
  const DietPlanPage({super.key});

  @override
  State<DietPlanPage> createState() => _DietPlanPageState();
}

class _DietPlanPageState extends State<DietPlanPage> {
  bool _isLoading = true;
  bool _showFavoritesOnly = false;

  @override
  void initState() {
    super.initState();
    _fetchDietPlans();
  }

  Future<void> _fetchDietPlans() async {
    final dietService = Provider.of<DietService>(context, listen: false);
    await dietService.fetchDietPlans();
    await dietService.fetchFavoriteDiets(context);
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dietService = Provider.of<DietService>(context);
    final dietPlans =
        _showFavoritesOnly
            ? dietService.dietPlans
                .where((plan) => dietService.favoriteDietIds.contains(plan.id))
                .toList()
            : dietService.dietPlans;
    return Scaffold(
      appBar: AppBar(title: const Text('Diet Plans')),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilterChip(
                  label: const Text('Show Favorites'),
                  selected: _showFavoritesOnly,
                  avatar: Icon(
                    Icons.star,
                    color: _showFavoritesOnly ? Colors.amber : Colors.grey,
                  ),
                  onSelected: (selected) {
                    setState(() {
                      _showFavoritesOnly = selected;
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : dietPlans.isEmpty
                    ? const Center(child: Text('No diet plans found.'))
                    : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: dietPlans.length,
                      itemBuilder: (context, index) {
                        final plan = dietPlans[index];
                        return Card(
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 16.0,
                            ),
                            leading: const Icon(Icons.restaurant_menu_outlined),
                            title: Text(
                              plan.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              plan.description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder:
                                      (child, animation) => ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                  child: IconButton(
                                    key: ValueKey<bool>(
                                      dietService.isFavoriteDiet(plan.id),
                                    ),
                                    icon: Icon(
                                      dietService.isFavoriteDiet(plan.id)
                                          ? Icons.star
                                          : Icons.star_border,
                                      color:
                                          dietService.isFavoriteDiet(plan.id)
                                              ? Colors.amber
                                              : Colors.grey,
                                    ),
                                    tooltip:
                                        dietService.isFavoriteDiet(plan.id)
                                            ? 'Remove from favorites'
                                            : 'Add to favorites',
                                    onPressed: () async {
                                      await dietService.toggleFavoriteDiet(
                                        context,
                                        plan.id,
                                      );
                                      setState(() {});
                                    },
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 18.0),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          DietPlanDetailPage(dietPlan: plan),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
