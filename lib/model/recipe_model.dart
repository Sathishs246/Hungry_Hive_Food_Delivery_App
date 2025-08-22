class Recipe {
  final int id;
  final String name;
  final List<String> ingredients;
  final List<String> instructions;
  final int prepTime;
  final int cookTime;
  final int servings;
  final String difficulty;
  final String cuisine;
  final int calories;
  final String image;
  final double rating;

  Recipe({
    required this.id,
    required this.name,
    required this.ingredients,
    required this.instructions,
    required this.prepTime,
    required this.cookTime,
    required this.servings,
    required this.difficulty,
    required this.cuisine,
    required this.calories,
    required this.image,
    required this.rating,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      name: json['name'] ?? '',
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
      prepTime: json['prepTimeMinutes'],
      cookTime: json['cookTimeMinutes'],
      servings: json['servings'],
      difficulty: json['difficulty'],
      cuisine: json['cuisine'],
      calories: json['caloriesPerServing'],
      image: json['image'],
      rating: json['rating'].toDouble(),
    );
  }
}
