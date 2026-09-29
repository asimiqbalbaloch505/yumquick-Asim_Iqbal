import 'package:flutter_bloc/flutter_bloc.dart';

class OrderItem {
  final String orderNo;
  final String title;
  final String date;
  final double price;
  final String status; // Active, Completed, Cancelled

  OrderItem({
    required this.orderNo,
    required this.title,
    required this.date,
    required this.price,
    required this.status,
  });
}

// Events
abstract class OrderEvent {}
class LoadOrders extends OrderEvent {}
class FilterOrders extends OrderEvent {
  final String status;
  FilterOrders(this.status);
}

// States
class OrderState {
  final String selectedTab;
  final List<OrderItem> orders;
  OrderState({required this.selectedTab, required this.orders});
}

// BLoC
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final List<OrderItem> _allOrders = [
    OrderItem(orderNo: '0054752', title: 'Strawberry Shake', date: '29 Nov, 01:20 pm', price: 20.00, status: 'Active'),
    OrderItem(orderNo: '0028762', title: 'Chicken Curry', date: '15 Nov, 05:20 pm', price: 50.00, status: 'Completed'),
    OrderItem(orderNo: '0881990', title: 'Sushi Wave', date: '02 Nov, 04:00 pm', price: 103.00, status: 'Cancelled'),
  ];

  OrderBloc() : super(OrderState(selectedTab: 'Active', orders: [])) {
    on<LoadOrders>((event, emit) {
      final active = _allOrders.where((o) => o.status == 'Active').toList();
      emit(OrderState(selectedTab: 'Active', orders: active));
    });

    on<FilterOrders>((event, emit) {
      final filtered = _allOrders.where((o) => o.status == event.status).toList();
      emit(OrderState(selectedTab: event.status, orders: filtered));
    });
  }
}