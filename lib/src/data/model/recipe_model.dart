class Recipe {
  final String id;
  final String name;
  final String category;
  final int timeForCooking;
  final int calories;
  final String region;
  final String imageUrl;
  final String description;
  final String? chefId;
  final List<Ingredient> ingredients;
  final List<Step> steps;
  final List<Ingredient>? fillings;
  final List<String> servingSuggestions;
  final String culturalNote;
  final List<String>? specialNote;
  final List<FAQ>? faq; // Added FAQ field

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.timeForCooking,
    required this.calories,
    required this.region,
    required this.imageUrl,
    required this.description,
    this.chefId,
    required this.ingredients,
    required this.steps,
    this.fillings,
    required this.servingSuggestions,
    required this.culturalNote,
    this.specialNote,
    this.faq, // Added FAQ parameter
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      timeForCooking: json['time_for_cooking'] ?? 0,
      calories: json['calories'] ?? 0,
      region: json['region'],
      imageUrl: json['image_url'],
      description: json['description'],
      chefId: json['chef_id'],
      ingredients:
          (json['ingredients'] as List)
              .map((i) => Ingredient.fromJson(i))
              .toList(),
      steps: (json['steps'] as List).map((s) => Step.fromJson(s)).toList(),
      fillings:
          json['fillings'] != null
              ? (json['fillings'] is List
                  ? (json['fillings'] as List)
                      .map((f) => Ingredient.fromJson(f))
                      .toList()
                  : null)
              : null,
      servingSuggestions: List<String>.from(json['serving_suggestions']),
      culturalNote: json['cultural_note'],
      specialNote:
          json['special_note'] != null
              ? List<String>.from(json['special_note'])
              : null,
      // Added FAQ parsing
      faq:
          json['faq'] != null
              ? (json['faq'] as List).map((f) => FAQ.fromJson(f)).toList()
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'time_for_cooking': timeForCooking,
      'calories': calories,
      'region': region,
      'image_url': imageUrl,
      'description': description,
      'chef_id': chefId,
      'ingredients': ingredients.map((i) => i.toJson()).toList(),
      'steps': steps.map((s) => s.toJson()).toList(),
      'fillings': fillings?.map((f) => f.toJson()).toList(),
      'serving_suggestions': servingSuggestions,
      'cultural_note': culturalNote,
      'special_note': specialNote,
      'faq': faq?.map((f) => f.toJson()).toList(), // Added FAQ serialization
    };
  }
}

class Ingredient {
  final String name;
  final String quantity;

  Ingredient({required this.name, required this.quantity});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(name: json['name'], quantity: json['quantity']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'quantity': quantity};
  }
}

class Step {
  final int stepNumber;
  final String instruction;

  Step({required this.stepNumber, required this.instruction});

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(
      stepNumber: json['step_number'],
      instruction: json['instruction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'step_number': stepNumber, 'instruction': instruction};
  }
}

// New FAQ class
class FAQ {
  final String question;
  final String answer;

  FAQ({required this.question, required this.answer});

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(question: json['question'], answer: json['answer']);
  }

  Map<String, dynamic> toJson() {
    return {'question': question, 'answer': answer};
  }
}
