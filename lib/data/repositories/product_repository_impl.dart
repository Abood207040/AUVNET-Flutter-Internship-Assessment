import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/product_entity.dart';
import '../../domain/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore _firestore;

  ProductRepositoryImpl(this._firestore);

  @override
  Future<List<ProductEntity>> fetchProducts() async {
    final snapshot = await _firestore.collection('products').get();
    return snapshot.docs.map((doc) {
      final data = doc.data();
      return ProductEntity(
        id: doc.id,
        name: data['name'] ?? '',
        description: data['description'] ?? '',
        price: (data['price'] ?? 0).toDouble(),
        imageUrl: data['imageUrl'] ?? '',
      );
    }).toList();
  }

  @override
  Future<ProductEntity?> getProductById(String id) async {
    final doc = await _firestore.collection('products').doc(id).get();
    if (!doc.exists) return null;
    final data = doc.data()!;
    return ProductEntity(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
    );
  }
} 