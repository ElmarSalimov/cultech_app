import 'package:cultech_app/core/l10n/localization_extension.dart';
import 'package:cultech_app/core/util/app_colors.dart';
import 'package:cultech_app/src/data/model/recipe_model.dart';
import 'package:cultech_app/src/presentation/screens/order_ingredient_screen.dart';
import 'package:flutter/material.dart';

class RecipeDetailScreen extends StatefulWidget {
  final Recipe recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  // Track completed steps
  late List<bool> completedSteps;
  // Track expanded FAQ items
  late List<bool> expandedFAQs;

  @override
  void initState() {
    super.initState();
    // Initialize all steps as incomplete
    completedSteps = List.filled(widget.recipe.steps.length, false);
    // Initialize all FAQs as collapsed
    expandedFAQs =
        widget.recipe.faq != null
            ? List.filled(widget.recipe.faq!.length, false)
            : [];
  }

  void _toggleStepCompletion(int index) {
    setState(() {
      completedSteps[index] = !completedSteps[index];
    });

    // Add haptic feedback for better UX
    if (completedSteps[index]) {
      // Vibrate when marking as complete
      // You can add haptic feedback here if needed
      // HapticFeedback.lightImpact();
    }
  }

  void _toggleFAQ(int index) {
    setState(() {
      expandedFAQs[index] = !expandedFAQs[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: CustomScrollView(
        slivers: [
          // App Bar with Recipe Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.appBar,
            iconTheme: const IconThemeData(color: AppColors.ivory),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Hero(
                    tag: 'recipe_image_${widget.recipe.id}',
                    child: Image.asset(
                      widget.recipe.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: AppColors.container,
                          child: Icon(
                            Icons.restaurant,
                            size: 80,
                            color: AppColors.iconColor,
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppColors.overlay],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Recipe Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Recipe Header
                  _buildRecipeHeader(),
                  const SizedBox(height: 20),

                  // Description
                  _buildSection(
                    title: Text(
                      context.localizations.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.maroon,
                      ),
                    ),
                    child: Text(
                      widget.recipe.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.subtitleText,
                        height: 1.5,
                      ),
                    ),
                  ),

                  // Ingredients
                  _buildSection(
                    title: Text(
                      context.localizations.ingredients,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.maroon,
                      ),
                    ),
                    child: _buildIngredientsList(),
                  ),

                  // Steps with progress indicator
                  _buildSection(
                    title: _buildStepsTitle(),
                    child: _buildStepsList(),
                  ),

                  // Cultural Note
                  _buildSection(
                    title: Text(
                      context.localizations.specialNotes,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.maroon,
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.container,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border, width: 1),
                      ),
                      child: Text(
                        widget.recipe.culturalNote,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.subtitleText,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),

                  // FAQ Section - Only show if FAQ data exists
                  if (widget.recipe.faq != null &&
                      widget.recipe.faq!.isNotEmpty)
                    _buildSection(
                      title: Row(
                        children: [
                          Icon(
                            Icons.help_outline,
                            color: AppColors.maroon,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            context.localizations.faq, // You can add this to localizations
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.maroon,
                            ),
                          ),
                        ],
                      ),
                      child: _buildFAQSection(),
                    ),

                  // Action Buttons
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder:
                                (context) => OrderIngredientsScreen(
                                  recipe: widget.recipe,
                                ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        foregroundColor: AppColors.ivory,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_cart, size: 24),
                      label: Text(
                        context.localizations.orderIngredients,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.recipe.name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.titleText,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.recipe.category,
                style: const TextStyle(
                  color: AppColors.ivory,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Icon(Icons.location_on, color: AppColors.iconColor, size: 24),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                widget.recipe.region,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.subtitleText,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({required Widget title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title,
        const SizedBox(height: 12),
        child,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildStepsTitle() {
    final completedCount =
        completedSteps.where((completed) => completed).length;
    final totalSteps = widget.recipe.steps.length;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.localizations.instructions,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.maroon,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color:
                completedCount == totalSteps
                    ? AppColors.green.withValues(alpha: 0.1)
                    : AppColors.cardBackground.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color:
                  completedCount == totalSteps
                      ? AppColors.green
                      : AppColors.cardBackground,
              width: 1,
            ),
          ),
          child: Text(
            '$completedCount/$totalSteps',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color:
                  completedCount == totalSteps
                      ? AppColors.green
                      : AppColors.titleText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIngredientsList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.container,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children:
            widget.recipe.ingredients.map((ingredient) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: AppColors.iconColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      flex: 3,
                      child: Text(
                        ingredient.name,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.subtitleText,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        ingredient.quantity,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.titleText,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildStepsList() {
    return Column(
      children:
          widget.recipe.steps.asMap().entries.map((entry) {
            final index = entry.key;
            final step = entry.value;
            final isCompleted = completedSteps[index];

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.only(bottom: 8),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _toggleStepCompletion(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color:
                          isCompleted
                              ? AppColors.green.withValues(alpha: 0.1)
                              : AppColors.container,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCompleted ? AppColors.green : AppColors.border,
                        width: isCompleted ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color:
                                isCompleted
                                    ? AppColors.green
                                    : AppColors.cardBackground,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child:
                                isCompleted
                                    ? const Icon(
                                      Icons.check,
                                      color: AppColors.ivory,
                                      size: 16,
                                    )
                                    : Text(
                                      '${step.stepNumber}',
                                      style: const TextStyle(
                                        color: AppColors.ivory,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  isCompleted
                                      ? AppColors.titleText.withValues(
                                        alpha: 0.7,
                                      )
                                      : AppColors.subtitleText,
                              height: 1.5,
                              decoration:
                                  isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                              decorationColor: AppColors.green,
                            ),
                            child: Text(step.instruction),
                          ),
                        ),
                        const SizedBox(width: 8),
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 300),
                          turns: isCompleted ? 0.25 : 0,
                          child: Icon(
                            isCompleted
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_right,
                            color:
                                isCompleted
                                    ? AppColors.green
                                    : AppColors.iconColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      children:
          widget.recipe.faq!.asMap().entries.map((entry) {
            final index = entry.key;
            final faq = entry.value;
            final isExpanded = expandedFAQs[index];

            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.container,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isExpanded ? AppColors.maroon : AppColors.border,
                  width: isExpanded ? 2 : 1,
                ),
              ),
              child: Material(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => _toggleFAQ(index),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color:
                                    isExpanded
                                        ? AppColors.maroon
                                        : AppColors.cardBackground,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                    color: AppColors.ivory,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                faq.question,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.titleText,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            AnimatedRotation(
                              duration: const Duration(milliseconds: 300),
                              turns: isExpanded ? 0.5 : 0,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color:
                                    isExpanded
                                        ? AppColors.maroon
                                        : AppColors.iconColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: isExpanded ? null : 0,
                          child:
                              isExpanded
                                  ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 12),
                                      Container(
                                        height: 1,
                                        color: AppColors.border,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 36,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 36,
                                        ),
                                        child: Text(
                                          faq.answer,
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.subtitleText,
                                            height: 1.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                  : const SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
