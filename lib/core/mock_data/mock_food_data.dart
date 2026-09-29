class FoodItemModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final String description;
  final String imageUrl;

  const FoodItemModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.description,
    required this.imageUrl,
  });
}

class MockFoodData {
  static const List<FoodItemModel> items = [
    FoodItemModel(
      id: '1',
      name: 'Strawberry Shake',
      category: 'Drinks',
      price: 20.00,
      rating: 4.8,
      description: 'Refreshing strawberry milk shake with fresh cream.',
      imageUrl: 'assets/images/strawberry_shake.png',
    ),
    FoodItemModel(
      id: '2',
      name: 'Chicken Burger',
      category: 'Meals',
      price: 20.00,
      rating: 4.6,
      description: 'Crispy chicken patty with lettuce and signature sauce.',
      imageUrl: 'assets/images/chicken_burger.png',
    ),
    FoodItemModel(
      id: '3',
      name: 'Sushi Wave',
      category: 'Meals',
      price: 103.00,
      rating: 4.9,
      description: 'Fresh salmon sushi roll set with soy sauce.',
      imageUrl: 'assets/images/sushi_wave.png',
    ),
    FoodItemModel(
      id: '4',
      name: 'Fruit and Berry Tea',
      category: 'Drinks',
      price: 15.00,
      rating: 4.5,
      description: 'Steeped berry tea infusion served cold.',
      imageUrl: 'assets/images/fruit_tea.png',
    ),
  ];
}