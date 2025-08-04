class FoodCategories {
  static FoodCategories? _instance;
  // Avoid self instance
  FoodCategories._();
  static FoodCategories get instance => _instance ??= FoodCategories._();

  static const String liquidFood = 'sulu yemək';
  static const String dryFood = 'quru yemək';
  static const String dessert = 'şirniyyat';
}
