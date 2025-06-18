import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/product_entity.dart';
import '../../domain/product_repository.dart';

abstract class ProductEvent {}
class LoadProducts extends ProductEvent {}

abstract class ProductState {}
class ProductInitial extends ProductState {}
class ProductLoading extends ProductState {}
class ProductLoaded extends ProductState {
  final List<ProductEntity> products;
  ProductLoaded(this.products);
}
class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repository;
  ProductBloc(this.repository) : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await repository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products'));
      }
    });
  }
} 