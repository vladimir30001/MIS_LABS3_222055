import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/obrok_detali_models.dart';
import '../services/API.dart';

class MealDetailScreen extends StatefulWidget {
  final String mealId;
  const MealDetailScreen({super.key, required this.mealId});

  @override
  State<MealDetailScreen> createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  MealDetail? meal;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMealDetail();
  }

  void fetchMealDetail() async {
    meal = await ApiService.getMealDetail(widget.mealId);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(meal?.name ?? 'Loading...')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(meal!.thumbnail),
            const SizedBox(height: 8),
            Text(meal!.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Category: ${meal!.category}'),
            const SizedBox(height: 8),
            const Text('Instructions:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(meal!.instructions),
            const SizedBox(height: 8),
            const Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...meal!.ingredients.entries
                .map((e) => Text('${e.key} - ${e.value}'))
                .toList(),
            if (meal!.youtube.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () => launchUrl(Uri.parse(meal!.youtube)),
                  child: const Text(
                    'Watch on YouTube',
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
