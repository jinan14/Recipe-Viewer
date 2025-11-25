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
  //runs once when screen opens
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
//search function
  void _search(String q) {
    final lower = q.toLowerCase();
    //calls the setState method to update the UI by the searched title or category
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
        backgroundColor: Colors.pinkAccent,
        elevation: 4,
        centerTitle: true,
        title: const Text(
          'Your Favorite Recipes',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),

        // Rounded bottom of the AppBar
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(56.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: TextField(
              //Every key typed triggers _search().
              onChanged: _search,
              decoration: InputDecoration(
                hintText: 'Search by title or category',
                hintStyle: TextStyle(color: Colors.black54),
                prefixIcon: Icon(Icons.search, color: Colors.black87),

                filled: true,
                fillColor: Colors.white,

                contentPadding: EdgeInsets.symmetric(vertical: 12),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),

                // Slight shadow to make it pop
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),

      //waits for recipes to load
      body: FutureBuilder<List<Recipe>>(
        future: _recipesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          } // loading
          if (snapshot.hasError) {
            return Center(child: Text('Failed to load recipes'));
          }// error
          if (_filtered.isEmpty) {
            return Center(child: Text('No recipes found'));
          }// empty no results found
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
                title: Text( r.title ),
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
