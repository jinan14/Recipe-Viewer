import 'package:flutter/material.dart';
import 'screens/recipe_list_screen.dart';

void main() {
  runApp(RecipeViewerApp());
}

class RecipeViewerApp extends StatelessWidget {
  const RecipeViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Viewer',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: RecipeListScreen(),
    );
  }
}
