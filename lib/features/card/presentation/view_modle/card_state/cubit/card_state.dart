part of 'card_cubit.dart';

@immutable
class CartState {
  final List<Map<String, dynamic>> items;

  const CartState({this.items = const []});

  CartState copyWith({List<Map<String, dynamic>>? items}) {
    return CartState(items: items ?? this.items);
  }
}
