import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/kategorii_models.dart';
import '../models/obrok_models.dart';
import '../models/obrok_detali_models.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));
    final data = json.decode(response.body);
    return (data['categories'] as List)
        .map((e) => Category.fromJson(e))
        .toList();
  }

  static Future<List<Meal>> getMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    final data = json.decode(response.body);
    return (data['meals'] as List)
        .map((e) => Meal.fromJson(e))
        .toList();
  }

  static Future<List<Meal>> searchMeals(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));
    final data = json.decode(response.body);
    if (data['meals'] == null) return [];
    return (data['meals'] as List)
        .map((e) => Meal.fromJson(e))
        .toList();
  }

  static Future<MealDetail> getMealDetail(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    final data = json.decode(response.body);
    return MealDetail.fromJson(data['meals'][0]);
  }

  static Future<MealDetail> getRandomMeal() async {
    final response = await http.get(Uri.parse('$baseUrl/random.php'));
    final data = json.decode(response.body);
    return MealDetail.fromJson(data['meals'][0]);
  }
}
