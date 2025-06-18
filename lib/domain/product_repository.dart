import 'product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> fetchProducts();
  Future<ProductEntity?> getProductById(String id);
} 