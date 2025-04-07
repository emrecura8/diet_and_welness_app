import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildNavigationCard(
    BuildContext context,
    String title,
    String routeName,
    IconData icon,
  ) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 16.0,
        ),
        leading: Icon(icon, size: 40.0),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18.0),
        onTap: () {
          Navigator.pushNamed(context, routeName);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              // TODO: Implement logout logic later
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          const SizedBox(height: 10),
          _buildNavigationCard(
            context,
            'My Profile',
            '/profile',
            Icons.person_outline,
          ),
          _buildNavigationCard(
            context,
            'Diet Plans',
            '/diet',
            Icons.restaurant_menu_outlined,
          ),
          _buildNavigationCard(
            context,
            'Exercises',
            '/exercise',
            Icons.fitness_center_outlined,
          ),
        ],
      ),
    );
  }
}
