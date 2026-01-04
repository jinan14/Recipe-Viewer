import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../utils/recipe_loader.dart';
import 'recipe_detail_screen.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  late Future<List<Recipe>> _futureRecipes;
  List<Recipe> _allRecipes = [];
  List<Recipe> _filteredRecipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes(); // Load all recipes initially
  }

  void _loadRecipes({String query = ''}) {
    setState(() {
      _futureRecipes = RecipeLoader.fetchRecipes(query: query);
    });
  }

  void _search(String query) {
    _loadRecipes(query: query); // Fetch from backend with search
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipes'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: TextField(
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search by title or category',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No recipes found'));
          } else {
            final recipes = snapshot.data!;
            return ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                return Card(
                  child: ListTile(
                    title: Text(recipe.title),
                    subtitle: Text('${recipe.category} • ${recipe.prepTime}'),
                    leading: Image.asset(
                      recipe.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RecipeDetailScreen(recipe: recipe),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
