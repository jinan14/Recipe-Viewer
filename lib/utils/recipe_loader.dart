import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class RecipeLoader {
  static const String baseUrl = 'http://jinanghannam.atwebpages.com/get_recipes.php';

  /// Fetch all recipes or search by query
  static Future<List<Recipe>> fetchRecipes({String query = ''}) async {
    final url = Uri.parse(query.isEmpty ? baseUrl : '$baseUrl?search=$query');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}