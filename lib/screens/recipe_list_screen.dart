import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../utils/recipe_loader.dart';
import 'recipe_detail_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({super.key});

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late Future<List<Recipe>> _recipesFuture;
  List<Recipe> _allRecipes = [];
  List<Recipe> _filtered = [];

  @override
  void initState() {
    super.initState();
    _recipesFuture = RecipeLoader.loadRecipes();
    _recipesFuture.then((list) {
      setState(() {
        _allRecipes = list;
        _filtered = list;
      });
    });
  }

  void _search(String q) {
    final lower = q.toLowerCase();
    setState(() {
      _filtered = _allRecipes.where((r) =>
      r.title.toLowerCase().contains(lower) ||
          r.category.toLowerCase().contains(lower)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search by title or category',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white.withValues(),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Failed to load recipes'));
          }
          if (_filtered.isEmpty) {
            return Center(child: Text('No recipes found'));
          }
          return ListView.builder(
            itemCount: _filtered.length,
            itemBuilder: (context, index) {
              final r = _filtered[index];
              return ListTile(
                leading: Hero(
                  tag: 'image-${r.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.asset(r.image, width: 64, height: 64, fit: BoxFit.cover),
                  ),
                ),
                title: Text(r.title),
                subtitle: Text('${r.description}\n${r.prepTime} • Serves ${r.servings}'),
                isThreeLine: true,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RecipeDetailScreen(recipe: r)),
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
