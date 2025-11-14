import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/recipe.dart';

class RecipeLoader {
  static Future<List<Recipe>> loadRecipes() async {
    final jsonStr = await rootBundle.loadString('assets/recipes.json');
    final List<dynamic> data = json.decode(jsonStr);
    return data.map((item) => Recipe.fromJson(item)).toList();
  }
}
