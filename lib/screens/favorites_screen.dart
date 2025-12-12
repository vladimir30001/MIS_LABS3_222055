import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../models/favorite_meal.dart';
import 'obrok_detali.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Recipes')),
      body: StreamBuilder<List<FavoriteMeal>>(
        stream: FavoritesService().getFavorites(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final favorites = snapshot.data!;
          if (favorites.isEmpty) {
            return const Center(child: Text('No favorite recipes yet.'));
          }

          return ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (context, index) {
              final meal = favorites[index];
              return ListTile(
                leading: Image.network(meal.thumbnail),
                title: Text(meal.name),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MealDetailScreen(mealId: meal.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
