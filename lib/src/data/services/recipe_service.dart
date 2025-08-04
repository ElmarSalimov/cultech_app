import 'dart:convert';
import 'package:cultech_app/src/data/model/recipe_model.dart';
import 'package:flutter/services.dart';

class RecipeService {
  static const String _jsonPath = 'assets/recipes.json';

  Future<List<Recipe>> loadRecipes() async {
    try {
      final String jsonString = await rootBundle.loadString(_jsonPath);
      final List<dynamic> jsonData = json.decode(jsonString);

      List<Recipe> recipes = [];
      for (int i = 0; i < jsonData.length; i++) {
        try {
          final recipe = Recipe.fromJson(jsonData[i]);
          // Modify the recipe imageUrl after creation
          final modifiedRecipe = Recipe(
            id: recipe.id,
            name: recipe.name,
            category: recipe.category,
            timeForCooking: recipe.timeForCooking,
            calories: recipe.calories,
            region: recipe.region,
            imageUrl: 'assets/images/image${i + 1}.jpg',
            description: recipe.description,
            chefId: recipe.chefId,
            ingredients: recipe.ingredients,
            steps: recipe.steps,
            fillings: recipe.fillings,
            servingSuggestions: recipe.servingSuggestions,
            culturalNote: recipe.culturalNote,
            specialNote: recipe.specialNote,
            faq: recipe.faq,
          );
          recipes.add(modifiedRecipe);
        } catch (e) {
          print('Error parsing recipe at index $i: $e');
          print('Recipe data: ${jsonData[i]}');
          // Continue with other recipes instead of failing completely
        }
      }

      return recipes;
    } catch (e) {
      print('Error loading recipes: $e');
      return [];
    }
  }

  Future<Recipe?> getRecipeById(String id) async {
    final recipes = await loadRecipes();
    try {
      return recipes.firstWhere((recipe) => recipe.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<Recipe>> searchRecipes(String query) async {
    final recipes = await loadRecipes();
    final lowercaseQuery = query.toLowerCase();

    return recipes.where((recipe) {
      return recipe.name.toLowerCase().contains(lowercaseQuery) ||
          recipe.description.toLowerCase().contains(lowercaseQuery) ||
          recipe.region.toLowerCase().contains(lowercaseQuery) ||
          recipe.ingredients.any(
            (ingredient) =>
                ingredient.name.toLowerCase().contains(lowercaseQuery),
          );
    }).toList();
  }

  Future<List<Recipe>> getRecipesByRegion(String region) async {
    final recipes = await loadRecipes();
    return recipes.where((recipe) => recipe.region == region).toList();
  }

  Future<List<Recipe>> getRecipesByCategory(String category) async {
    final recipes = await loadRecipes();
    return recipes.where((recipe) => recipe.category == category).toList();
  }

  // Additional utility methods for the new fields
  Future<List<Recipe>> getRecipesByMaxTime(int maxMinutes) async {
    final recipes = await loadRecipes();
    return recipes
        .where((recipe) => recipe.timeForCooking <= maxMinutes)
        .toList();
  }

  Future<List<Recipe>> getRecipesByMaxCalories(int maxCalories) async {
    final recipes = await loadRecipes();
    return recipes.where((recipe) => recipe.calories <= maxCalories).toList();
  }

  Future<List<Recipe>> getQuickRecipes() async {
    final recipes = await loadRecipes();
    return recipes.where((recipe) => recipe.timeForCooking <= 30).toList();
  }

  Future<List<Recipe>> getLowCalorieRecipes() async {
    final recipes = await loadRecipes();
    return recipes.where((recipe) => recipe.calories <= 300).toList();
  }
}
