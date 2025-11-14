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
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      prepTime: json['prepTime'] as String,
      servings: (json['servings'] is int) ? json['servings'] as int : int.parse(json['servings'].toString()),
      ingredients: List<String>.from(json['ingredients'] ?? []),
      steps: List<String>.from(json['steps'] ?? []),
      category: json['category'] as String? ?? '',
    );
  }
}
