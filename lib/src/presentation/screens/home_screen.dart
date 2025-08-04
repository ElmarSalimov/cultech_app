import 'package:cultech_app/core/l10n/localization_extension.dart';
import 'package:cultech_app/core/util/app_colors.dart';
import 'package:cultech_app/src/data/model/recipe_model.dart';
import 'package:cultech_app/src/data/services/recipe_service.dart';
import 'package:cultech_app/src/presentation/screens/recipe_detail_screen.dart';
import 'package:cultech_app/src/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeService _recipeService = RecipeService();
  List<Recipe> _allRecipes = [];
  List<Recipe> _liquidFoods = [];
  List<Recipe> _dryFoods = [];
  List<Recipe> _desserts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final recipes = await _recipeService.loadRecipes();
    setState(() {
      _allRecipes = recipes;
      // Categorize recipes based on their category field
      _liquidFoods =
          recipes.where((recipe) => recipe.category == 'sulu yemək').toList();

      _dryFoods =
          recipes.where((recipe) => recipe.category == 'quru yemək').toList();

      _desserts =
          recipes.where((recipe) => recipe.category == 'şirniyyat').toList();

      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: AppColors.cardBackground,
        centerTitle: true,
        title: Text(
          'DadYolu',
          style: TextStyle(
            fontFamily: 'SF-Pro-Display',
            fontWeight: FontWeight.w600,
            fontSize: 26,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
          SizedBox(width: 8),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),

                    // Welcome section
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        border: Border.all(
                          width: 2,
                          color: Colors.blue.shade200,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.localizations.welcomeMessage,
                            style: TextStyle(
                              fontFamily: 'SF-Pro-Display',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                            ),
                          ),
                          Text(
                            context.localizations.todayQuestion,
                            style: TextStyle(
                              fontFamily: 'SF-Pro-Display',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Dry foods section
                    if (_dryFoods.isNotEmpty)
                      _buildRecipeSection(
                        context.localizations.dryFoods,
                        const Color(0xFFD4AF37),
                        _dryFoods,
                      ),

                    SizedBox(height: 20),

                    // Liquid foods section
                    if (_liquidFoods.isNotEmpty)
                      _buildRecipeSection(
                        context.localizations.liquidFoods,
                        const Color(0xFFDC143C),
                        _liquidFoods,
                      ),

                    // Desserts section
                    if (_desserts.isNotEmpty) ...[
                      SizedBox(height: 20),
                      _buildRecipeSection(
                        context.localizations.desserts,
                        const Color(0xFF8B4513),
                        _desserts,
                      ),
                    ],

                    SizedBox(height: 30),

                    // Today's Menu Section
                    _buildTodaysMenuSection(context),

                    SizedBox(height: 30),
                  ],
                ),
              ),
    );
  }

  Widget _buildTodaysMenuSection(BuildContext context) {
    // Get featured recipes for today's menu (example: first recipe from each category)
    List<Recipe> todaysMenu = [];
    if (_dryFoods.isNotEmpty) todaysMenu.add(_dryFoods.first);
    if (_liquidFoods.isNotEmpty) todaysMenu.add(_liquidFoods.first);
    if (_desserts.isNotEmpty) todaysMenu.add(_desserts.first);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(Icons.today, color: Colors.orange.shade700, size: 26),
              SizedBox(width: 8),
              Text(
                "Bugünün Menyusu",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2F1B14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.orange.shade50, Colors.amber.shade50],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.orange.shade200, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.shade100,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                    topRight: Radius.circular(18),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.restaurant_menu,
                      color: Colors.orange.shade700,
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "Aşpazımızın tövsiyələri",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "YENİ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Menu Items
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children:
                      todaysMenu.asMap().entries.map((entry) {
                        int index = entry.key;
                        Recipe recipe = entry.value;
                        bool isLast = index == todaysMenu.length - 1;

                        return Column(
                          children: [
                            _buildTodaysMenuItem(recipe, context),
                            if (!isLast)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Divider(
                                  color: Colors.orange.shade200,
                                  thickness: 1,
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                ),
              ),

              // Action Button
              Padding(
                padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Show all today's menu or navigate to special menu screen
                      _showTodaysMenuDialog(context, todaysMenu);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade600,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    icon: Icon(Icons.visibility, size: 20),
                    label: Text(
                      "Tam menyunu gör",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTodaysMenuItem(Recipe recipe, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.shade100, width: 1),
        ),
        child: Row(
          children: [
            // Recipe Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                recipe.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey.shade300,
                    child: Icon(
                      Icons.restaurant,
                      size: 30,
                      color: Colors.grey.shade600,
                    ),
                  );
                },
              ),
            ),
            SizedBox(width: 12),

            // Recipe Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.orange.shade600,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${recipe.timeForCooking} dəq',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(width: 12),
                      Icon(
                        Icons.local_fire_department,
                        size: 14,
                        color: Colors.red.shade600,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${recipe.calories} kkal',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Category Badge
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(recipe.category),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _getCategoryName(recipe.category),
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'quru yemək':
        return Colors.amber.shade600;
      case 'sulu yemək':
        return Colors.blue.shade600;
      case 'şirniyyat':
        return Colors.purple.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  String _getCategoryName(String category) {
    switch (category) {
      case 'quru yemək':
        return 'QURU';
      case 'sulu yemək':
        return 'SULU';
      case 'şirniyyat':
        return 'ŞIRIN';
      default:
        return 'YEMƏK';
    }
  }

  void _showTodaysMenuDialog(BuildContext context, List<Recipe> todaysMenu) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.today, color: Colors.orange.shade700),
              SizedBox(width: 8),
              Text(
                "Bugünün Menyusu",
                style: TextStyle(
                  color: Colors.orange.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: todaysMenu.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final recipe = todaysMenu[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      recipe.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.shade300,
                          child: Icon(Icons.restaurant, size: 25),
                        );
                      },
                    ),
                  ),
                  title: Text(
                    recipe.name,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    '${recipe.timeForCooking} dəq • ${recipe.calories} kkal',
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => RecipeDetailScreen(recipe: recipe),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Bağla",
                style: TextStyle(color: Colors.orange.shade700),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecipeSection(
    String title,
    Color accentColor,
    List<Recipe> recipes,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2F1B14),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 4),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12),
            itemCount: recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipes[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreen(recipe: recipe),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.white, Colors.grey.shade50],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Recipe image with Hero animation
                      Hero(
                        tag: 'recipe_image_${recipe.id}',
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.asset(
                              recipe.imageUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade300,
                                  child: Icon(
                                    Icons.restaurant,
                                    size: 40,
                                    color: Colors.grey.shade600,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Recipe name
                              Text(
                                recipe.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2F1B14),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 6),

                              // Time and Calories row
                              Row(
                                children: [
                                  // Cooking time
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: Colors.orange.shade700,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${recipe.timeForCooking}${context.localizations.minutesShort}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.orange.shade700,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(width: 8),

                                  // Calories
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_fire_department,
                                        size: 14,
                                        color: Colors.red.shade600,
                                      ),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${recipe.calories}${context.localizations.caloriesShort}',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.red.shade600,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 6),

                              // Special notes
                              if (recipe.specialNote != null &&
                                  recipe.specialNote!.isNotEmpty)
                                Expanded(
                                  child: Wrap(
                                    spacing: 4,
                                    runSpacing: 2,
                                    children:
                                        recipe.specialNote!.take(2).map((note) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 6,
                                              vertical: 2,
                                            ),
                                            decoration: BoxDecoration(
                                              color: _getNoteColor(
                                                note,
                                              ).withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                color: _getNoteColor(
                                                  note,
                                                ).withValues(alpha: 0.3),
                                                width: 0.5,
                                              ),
                                            ),
                                            child: Text(
                                              _getNoteText(note, context),
                                              style: TextStyle(
                                                fontSize: 8,
                                                color: _getNoteColor(note),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Color _getNoteColor(String note) {
    switch (note.toLowerCase()) {
      case 'isti servis':
        return Colors.red.shade700;
      case 'soyuq servis':
        return Colors.blue.shade700;
      case 'vegetarian':
        return Colors.green.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  String _getNoteText(String note, BuildContext context) {
    switch (note.toLowerCase()) {
      case 'isti servis':
        return context.localizations.hotService;
      case 'soyuq servis':
        return context.localizations.coldService;
      case 'vegetarian':
        return context.localizations.vegetarian;
      default:
        return note;
    }
  }
}
