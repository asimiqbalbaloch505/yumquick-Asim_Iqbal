import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/mock_data/mock_food_data.dart';

class CartItem {
  final FoodItemModel food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});
}

// Events
abstract class CartEvent {}

class AddToCart extends CartEvent {
  final FoodItemModel food;
  AddToCart(this.food);
}

class UpdateQuantity extends CartEvent {
  final String foodId;
  final int delta;
  UpdateQuantity(this.foodId, this.delta);
}

class ClearCart extends CartEvent {}

// States
class CartState {
  final List<CartItem> items;
  CartState(this.items);

  double get subtotal => items.fold(0, (sum, item) => sum + (item.food.price * item.quantity));
  double get tax => subtotal * 0.1;
  double get deliveryFee => items.isEmpty ? 0 : 3.0;
  double get total => subtotal + tax + deliveryFee;
}

// BLoC
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc()
      : super(CartState([
    CartItem(food: MockFoodData.items[0], quantity: 1),
    CartItem(food: MockFoodData.items[1], quantity: 2),
  ])) {
    on<AddToCart>((event, emit) {
      final updated = List<CartItem>.from(state.items);
      final index = updated.indexWhere((item) => item.food.id == event.food.id);
      if (index >= 0) {
        updated[index].quantity += 1;
      } else {
        updated.add(CartItem(food: event.food));
      }
      emit(CartState(updated));
    });

    on<UpdateQuantity>((event, emit) {
      final updated = List<CartItem>.from(state.items);
      final index = updated.indexWhere((item) => item.food.id == event.foodId);
      if (index >= 0) {
        updated[index].quantity += event.delta;
        if (updated[index].quantity <= 0) {
          updated.removeAt(index);
        }
      }
      emit(CartState(updated));
    });

    on<ClearCart>((event, emit) {
      emit(CartState([]));
    });
  }
}