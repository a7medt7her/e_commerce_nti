import 'package:bloc/bloc.dart';

part 'product_view_state.dart';

class ProductViewCubit extends Cubit<ProductViewState> {
  ProductViewCubit({required this.price})
    : super(ProductViewState(quantity: 1, totalPrice: price));

  final num price;

  void increment() {
    final quantity = state.quantity + 1;

    emit(ProductViewState(quantity: quantity, totalPrice: quantity * price));
  }

  void decrement() {
    if (state.quantity == 1) return;

    final quantity = state.quantity - 1;

    emit(ProductViewState(quantity: quantity, totalPrice: quantity * price));
  }
}
