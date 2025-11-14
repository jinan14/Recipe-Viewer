import 'package:flutter/material.dart';
import 'screens/recipe_list_screen.dart';

void main() {
  runApp(RecipeViewerApp());
}

class RecipeViewerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Viewer',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: RecipeListScreen(),
    );
  }
}
