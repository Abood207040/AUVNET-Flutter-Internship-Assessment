import 'package:hive/hive.dart';
import '../../domain/cart_item_entity.dart';
import '../../domain/cart_repository.dart';
import '../../domain/product_entity.dart';

class CartRepositoryImpl implements CartRepository {
  static const _cartBox = 'cart';

  @override
  Future<List<CartItemEntity>> getCartItems() async {
    final box = await Hive.openBox(_cartBox);
    final items = box.values.map((item) {
      final map = Map<String, dynamic>.from(item);
      return CartItemEntity(
        product: ProductEntity(
          id: map['productId'],
          name: map['productName'],
          description: map['productDescription'],
          price: map['productPrice'],
          imageUrl: map['productImageUrl'],
        ),
        quantity: map['quantity'],
      );
    }).toList();
    return items;
  }

  @override
  Future<void> addToCart(CartItemEntity item) async {
    final box = await Hive.openBox(_cartBox);
    await box.put(item.product.id, {
      'productId': item.product.id,
      'productName': item.product.name,
      'productDescription': item.product.description,
      'productPrice': item.product.price,
      'productImageUrl': item.product.imageUrl,
      'quantity': item.quantity,
    });
  }

  @override
  Future<void> removeFromCart(String productId) async {
    final box = await Hive.openBox(_cartBox);
    await box.delete(productId);
  }

  @override
  Future<void> clearCart() async {
    final box = await Hive.openBox(_cartBox);
    await box.clear();
  }
} 