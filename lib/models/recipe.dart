import 'dart:convert';

class Recipe {
  final int id;
  final String title;
  final String description;
  final String image; // asset path
  final String prepTime;
  final int servings;
  final List<String> ingredients;
  final List<String> steps;
  final String category;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.prepTime,
    required this.servings,
    required this.ingredients,
    required this.steps,
    required this.category,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      prepTime: json['prepTime'] ?? '',
      servings: int.tryParse(json['servings'].toString()) ?? 0,
      ingredients: (json['ingredients'] is String)
          ? List<String>.from(jsonDecode(json['ingredients']))
          : List<String>.from(json['ingredients'] ?? []),
      steps: (json['steps'] is String)
          ? List<String>.from(jsonDecode(json['steps']))
          : List<String>.from(json['steps'] ?? []),
      category: json['category'] ?? '',
    );
  }

}
