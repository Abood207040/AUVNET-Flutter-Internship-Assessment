import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/product_entity.dart';
import '../../domain/cart_item_entity.dart';
import '../bloc/cart_bloc.dart';

var sandwiches = [
  ProductEntity(
    id: 'sandwich1',
    name: 'Chicken Sandwich',
    description: 'Grilled chicken, lettuce, tomato, and mayo.',
    price: 5.99,
    imageUrl: 'https://images.unsplash.com/photo-1519864600265-abb23847ef2c',
  ),
   ProductEntity(
    id: 'sandwich2',
    name: 'Beef Sandwich',
    description: 'Roast beef, cheese, onions, and BBQ sauce.',
    price: 6.99,
    imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
  ),
   ProductEntity(
    id: 'sandwich3',
    name: 'Veggie Sandwich',
    description: 'Lettuce, tomato, cucumber, and hummus.',
    price: 4.99,
    imageUrl: 'https://images.unsplash.com/photo-1464306076886-debca5e8a6b0',
  ),
];

class FoodSandwichesScreen extends StatelessWidget {
  const FoodSandwichesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sandwiches')),
      body: ListView.builder(
        itemCount: sandwiches.length,
        itemBuilder: (context, index) {
          final sandwich = sandwiches[index];
          return Card(
            child: ListTile(
              leading: Image.network(
                sandwich.imageUrl,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.fastfood),
              ),
              title: Text(sandwich.name),
              subtitle: Text(' 24${sandwich.price.toStringAsFixed(2)}'),
              onTap: () => _showQuantityDialog(context, sandwich),
            ),
          );
        },
      ),
    );
  }

  void _showQuantityDialog(BuildContext context, ProductEntity sandwich) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Add ${sandwich.name}'),
          content: Row(
            children: [
              const Text('Quantity: '),
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setState) => Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() => quantity--);
                          }
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() => quantity++);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CartBloc>().add(
                  AddToCart(CartItemEntity(product: sandwich, quantity: quantity)),
                );
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${sandwich.name} x$quantity added to cart!')),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
} 