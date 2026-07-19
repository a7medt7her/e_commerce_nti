part of 'product_view_cubit.dart';

class ProductViewState {
  final int quantity;
  final num totalPrice;

  const ProductViewState({required this.quantity, required this.totalPrice});

  ProductViewState copyWith({int? quantity, num? totalPrice}) {
    return ProductViewState(
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
