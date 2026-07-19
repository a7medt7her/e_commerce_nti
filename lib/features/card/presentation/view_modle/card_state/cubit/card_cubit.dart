import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'card_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartState());

  void addToCart({
    required int productId,
    required String image,
    required String title,
    required num price,
    required num rating,
    required int quantity,
  }) {
    final items = List<Map<String, dynamic>>.from(state.items);

    final index = items.indexWhere((item) => item["productId"] == productId);

    if (index != -1) {
      items[index]["quantity"] += quantity;
    } else {
      items.add({
        "productId": productId,
        "image": image,
        "title": title,
        "price": price,
        "rating": rating,
        "quantity": quantity,
      });
    }

    emit(state.copyWith(items: items));
  }

  void increment(int productId) {
    final items = List<Map<String, dynamic>>.from(state.items);

    final index = items.indexWhere((item) => item["productId"] == productId);

    if (index != -1) {
      items[index]["quantity"]++;
      emit(state.copyWith(items: items));
    }
  }

  void decrement(int productId) {
    final items = List<Map<String, dynamic>>.from(state.items);

    final index = items.indexWhere((item) => item["productId"] == productId);

    if (index == -1) return;

    if (items[index]["quantity"] > 1) {
      items[index]["quantity"]--;
    } else {
      items.removeAt(index);
    }

    emit(state.copyWith(items: items));
  }

  void removeProduct(int productId) {
    final items = List<Map<String, dynamic>>.from(state.items);

    items.removeWhere((item) => item["productId"] == productId);

    emit(state.copyWith(items: items));
  }

  void clearCart() {
    emit(state.copyWith(items: []));
  }
}
