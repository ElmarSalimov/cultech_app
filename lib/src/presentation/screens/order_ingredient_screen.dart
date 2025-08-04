import 'package:cultech_app/core/l10n/localization_extension.dart';
import 'package:flutter/material.dart';
import 'package:cultech_app/core/util/app_colors.dart';
import 'package:cultech_app/src/data/model/recipe_model.dart';

class OrderIngredientsScreen extends StatefulWidget {
  final Recipe recipe;

  const OrderIngredientsScreen({super.key, required this.recipe});

  @override
  State<OrderIngredientsScreen> createState() => _OrderIngredientsScreenState();
}

class _OrderIngredientsScreenState extends State<OrderIngredientsScreen> {
  int selectedPortions = 1;
  Map<String, int> selectedIngredients = {};
  Map<String, double> baseQuantities = {};

  @override
  void initState() {
    super.initState();
    _initializeIngredients();
  }

  void _initializeIngredients() {
    for (var ingredient in widget.recipe.ingredients) {
      selectedIngredients[ingredient.name] = 0;
      // Parse quantity to get numeric value
      baseQuantities[ingredient.name] = _parseQuantity(ingredient.quantity);
    }
  }

  double _parseQuantity(String quantity) {
    // Extract numeric value from quantity string
    RegExp regExp = RegExp(r'(\d+\.?\d*)');
    Match? match = regExp.firstMatch(quantity);
    if (match != null) {
      return double.parse(match.group(1)!);
    }
    return 1.0; // Default if no number found
  }

  int _getMaxQuantity(String ingredientName) {
    return (baseQuantities[ingredientName]! * selectedPortions).ceil();
  }

  double _getTotalPrice() {
    // Mock pricing - you can replace with actual pricing logic
    double total = 0.0;
    selectedIngredients.forEach((name, quantity) {
      total += quantity * 2.5; // 2.5 AZN per unit as example
    });
    return total;
  }

  int _getTotalSelectedItems() {
    return selectedIngredients.values.fold(
      0,
      (sum, quantity) => sum + quantity,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.appBar,
        iconTheme: const IconThemeData(color: AppColors.ivory),
        title: Text(
          context.localizations.ingredientOrder,
          style: TextStyle(color: AppColors.ivory, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Info Card
                  _buildRecipeInfoCard(),
                  const SizedBox(height: 20),

                  // Portions Selector
                  _buildPortionsSelector(),
                  const SizedBox(height: 24),

                  // Ingredients List
                  _buildIngredientsSection(),
                ],
              ),
            ),
          ),

          // Bottom Order Summary
          _buildOrderSummary(context),
        ],
      ),
    );
  }

  Widget _buildRecipeInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.recipe.imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 60,
                  height: 60,
                  color: AppColors.iconColor.withValues(alpha: 0.1),
                  child: Icon(
                    Icons.restaurant,
                    color: AppColors.iconColor,
                    size: 30,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.recipe.name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titleText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.recipe.region,
                  style: TextStyle(fontSize: 14, color: AppColors.subtitleText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortionsSelector() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.people, color: AppColors.iconColor, size: 20),
              const SizedBox(width: 8),
              Text(
                context.localizations.portionCount,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPortionButton(
                icon: Icons.remove,
                onPressed:
                    selectedPortions > 1
                        ? () {
                          setState(() {
                            selectedPortions--;
                            // Reset selected ingredients when portions change
                            selectedIngredients.updateAll((key, value) => 0);
                          });
                        }
                        : null,
              ),
              const SizedBox(width: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),

                child: Text(
                  '$selectedPortions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titleText,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              _buildPortionButton(
                icon: Icons.add,
                onPressed:
                    selectedPortions < 10
                        ? () {
                          setState(() {
                            selectedPortions++;
                            // Reset selected ingredients when portions change
                            selectedIngredients.updateAll((key, value) => 0);
                          });
                        }
                        : null,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            context.localizations.maxPortions,
            style: TextStyle(
              fontSize: 12,
              color: AppColors.subtitleText,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPortionButton({
    required IconData icon,
    VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color:
            onPressed != null
                ? AppColors.lightBlue
                : AppColors.subtitleText.withValues(alpha: 0.3),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: AppColors.ivory, size: 20),
      ),
    );
  }

  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.shopping_basket, color: AppColors.iconColor, size: 20),
            const SizedBox(width: 8),
            Text(
              context.localizations.ingredients,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.titleText,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          context.localizations.orderIngredients,
          style: TextStyle(fontSize: 14, color: AppColors.subtitleText),
        ),
        const SizedBox(height: 16),
        ...widget.recipe.ingredients.map(
          (ingredient) => _buildIngredientItem(ingredient),
        ),
      ],
    );
  }

  Widget _buildIngredientItem(Ingredient ingredient) {
    int maxQuantity = _getMaxQuantity(ingredient.name);
    int selectedQuantity = selectedIngredients[ingredient.name] ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selectedQuantity > 0 ? AppColors.green : AppColors.border,
          width: selectedQuantity > 0 ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ingredient.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.titleText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${context.localizations.forRecipe} ${ingredient.quantity}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.subtitleText,
                      ),
                    ),
                    Text(
                      '${context.localizations.maximum}: $maxQuantity ${context.localizations.pieces}',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${(selectedQuantity * 2.5).toStringAsFixed(2)} ₼',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed:
                    selectedQuantity > 0
                        ? () {
                          setState(() {
                            selectedIngredients[ingredient.name] =
                                selectedQuantity - 1;
                          });
                        }
                        : null,
                style: IconButton.styleFrom(
                  backgroundColor:
                      selectedQuantity > 0
                          ? AppColors.red.withValues(alpha: 0.1)
                          : AppColors.subtitleText.withValues(alpha: 0.1),
                  foregroundColor:
                      selectedQuantity > 0
                          ? AppColors.red
                          : AppColors.subtitleText,
                ),
                icon: const Icon(Icons.remove, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color:
                      selectedQuantity > 0
                          ? AppColors.green.withValues(alpha: 0.1)
                          : AppColors.container,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color:
                        selectedQuantity > 0
                            ? AppColors.green
                            : AppColors.border,
                    width: 1,
                  ),
                ),
                child: Text(
                  '$selectedQuantity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.titleText,
                  ),
                ),
              ),
              IconButton(
                onPressed:
                    selectedQuantity < maxQuantity
                        ? () {
                          setState(() {
                            selectedIngredients[ingredient.name] =
                                selectedQuantity + 1;
                          });
                        }
                        : null,
                style: IconButton.styleFrom(
                  backgroundColor:
                      selectedQuantity < maxQuantity
                          ? AppColors.green.withValues(alpha: 0.1)
                          : AppColors.subtitleText.withValues(alpha: 0.1),
                  foregroundColor:
                      selectedQuantity < maxQuantity
                          ? AppColors.green
                          : AppColors.subtitleText,
                ),
                icon: const Icon(Icons.add, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    int totalItems = _getTotalSelectedItems();
    double totalPrice = _getTotalPrice();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(color: AppColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${context.localizations.totalProducts}: $totalItems ${context.localizations.pieces}',
                style: TextStyle(fontSize: 14, color: AppColors.subtitleText),
              ),
              Text(
                '${totalPrice.toStringAsFixed(2)} ₼',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.titleText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton.icon(
              onPressed:
                  totalItems > 0
                      ? () {
                        _showOrderConfirmation(context);
                      }
                      : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    totalItems > 0 ? AppColors.green : AppColors.subtitleText,
                foregroundColor: AppColors.ivory,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.shopping_cart_checkout, size: 20),
              label: Text(
                totalItems > 0
                    ? context.localizations.confirmOrder
                    : context.localizations.selectProducts,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showOrderConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.container,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            context.localizations.confirmOrder,
            style: TextStyle(
              color: AppColors.titleText,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            context.localizations.orderSuccessMessage,
            style: TextStyle(color: AppColors.subtitleText),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to recipe detail
              },
              child: Text(
                context.localizations.okay,
                style: TextStyle(
                  color: AppColors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
