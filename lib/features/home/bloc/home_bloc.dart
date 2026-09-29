import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/mock_data/mock_food_data.dart';

// Events
abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {}

class SelectCategory extends HomeEvent {
  final String category;
  SelectCategory(this.category);
}

class SearchQueryChanged extends HomeEvent {
  final String query;
  SearchQueryChanged(this.query);
}

// States
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<String> categories;
  final String selectedCategory;
  final List<FoodItemModel> items;

  HomeLoaded({
    required this.categories,
    required this.selectedCategory,
    required this.items,
  });
}

// BLoC
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final List<String> _categories = ['All', 'Drinks', 'Meals', 'Vegan', 'Desserts'];

  HomeBloc() : super(HomeLoading()) {
    on<LoadHomeData>((event, emit) {
      emit(HomeLoaded(
        categories: _categories,
        selectedCategory: 'All',
        items: MockFoodData.items,
      ));
    });

    on<SelectCategory>((event, emit) {
      final filteredItems = event.category == 'All'
          ? MockFoodData.items
          : MockFoodData.items.where((item) => item.category == event.category).toList();

      emit(HomeLoaded(
        categories: _categories,
        selectedCategory: event.category,
        items: filteredItems,
      ));
    });

    on<SearchQueryChanged>((event, emit) {
      final query = event.query.toLowerCase();
      final filteredItems = MockFoodData.items.where((item) {
        return item.name.toLowerCase().contains(query);
      }).toList();

      emit(HomeLoaded(
        categories: _categories,
        selectedCategory: 'All',
        items: filteredItems,
      ));
    });
  }
}