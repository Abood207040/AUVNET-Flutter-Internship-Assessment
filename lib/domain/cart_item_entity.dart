import 'product_entity.dart';

class CartItemEntity {
  final ProductEntity product;
  final int quantity;

  CartItemEntity({required this.product, required this.quantity});
} 