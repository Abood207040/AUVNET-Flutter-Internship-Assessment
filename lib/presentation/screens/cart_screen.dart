import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../bloc/cart_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  Future<void> _saveOrderToFirestore(BuildContext context, List items) async {
    final order = {
      'items': items
          .map((item) => {
                'id': item.product.id,
                'name': item.product.name,
                'quantity': item.quantity,
                'price': item.product.price,
              })
          .toList(),
      'timestamp': FieldValue.serverTimestamp(),
    };
    await FirebaseFirestore.instance.collection('orders').add(order);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final items = state.items;
            if (items.isEmpty) {
              return const Center(child: Text('Your cart is empty.'));
            }
            final total = items.fold<double>(0, (sum, item) => sum + item.product.price * item.quantity);
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[index];
                      return ListTile(
                        title: Text(item.product.name),
                        subtitle: Text('Quantity: ${item.quantity}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<CartBloc>().add(RemoveFromCart(item.product.id));
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: \u0024${total.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ElevatedButton(
                        onPressed: () {
                          context.read<CartBloc>().add(ClearCart());
                        },
                        child: const Text('Clear Cart'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        await _saveOrderToFirestore(context, items);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Order confirmed and saved!')),
                        );
                        context.read<CartBloc>().add(ClearCart());
                      },
                      child: const Text('Confirm Order'),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
} 