import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(recipe.image),
            const SizedBox(height: 12),
            Text('Category: ${recipe.category}', style: const TextStyle(fontWeight: FontWeight.bold)),
            Text('Prep Time: ${recipe.prepTime}'),
            Text('Servings: ${recipe.servings}'),
            const SizedBox(height: 16),
            const Text('Ingredients:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...recipe.ingredients.map((i) => Text('• $i')).toList(),
            const SizedBox(height: 16),
            const Text('Steps:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ...recipe.steps.asMap().entries.map((e) => Text('${e.key + 1}. ${e.value}')).toList(),
          ],
        ),
      ),
    );
  }
}
