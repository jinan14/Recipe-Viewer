import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailScreen({required this.recipe});

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Text(text, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.asMap().entries.map((e) {
        final idx = e.key + 1;
        final val = e.value;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text('$idx. $val'),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: 'image-${recipe.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(recipe.image, width: double.infinity, height: 220, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(recipe.prepTime, style: TextStyle(fontWeight: FontWeight.w600)),
                Text('Serves ${recipe.servings}', style: TextStyle(fontWeight: FontWeight.w600)),
              ],
            ),
            _buildSectionTitle('Ingredients'),
            _buildList(recipe.ingredients),
            _buildSectionTitle('Steps'),
            _buildList(recipe.steps),
            SizedBox(height: 24),
            Center(child: Text('Category: ${recipe.category}', style: TextStyle(color: Colors.grey[700]))),
          ],
        ),
      ),
    );
  }
}
