import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/repositories/cart_repository_impl.dart';
import 'package:task/presentation/screens/cart_screen.dart';
import '../../domain/product_repository.dart';
import '../bloc/product_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/repositories/product_repository_impl.dart';
import 'food_sandwiches_screen.dart';
import '../bloc/cart_bloc.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductBloc(ProductRepositoryImpl(FirebaseFirestore.instance))..add(LoadProducts()),
        ),
        BlocProvider(
          create: (_) => CartBloc(),
        ),
      ],
      child: StatefulBuilder(
        builder: (context, setState) => Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            onTap: (index) async {
              if (index == 1) {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<CartBloc>(context),
                      child: FoodSandwichesScreen(),
                    ),
                  ),
                );
                setState(() {
                  _selectedIndex = 0;
                });
              } else {
                setState(() {
                  _selectedIndex = index;
                });
                if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<CartBloc>(context),
                        child: CartScreen(),
                      ),
                    ),
                  );
                }
              }
            },
            items: [
              const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              const BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: "Categories"),
              const BottomNavigationBarItem(icon: Icon(Icons.delivery_dining), label: "Deliver"),
              BottomNavigationBarItem(
                icon: BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    int itemCount = 0;
                    if (state is CartLoaded) {
                      itemCount = state.items.fold(0, (sum, item) => sum + item.quantity);
                    }
                    return Stack(
                      children: [
                        const Icon(Icons.shopping_cart),
                        if (itemCount > 0)
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                              child: Text(
                                '$itemCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                label: "Cart",
              ),
              const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF9C27B0), Color(0xFFFFC107)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Delivering to", style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 4),
                          Text("Al Satwa, 81A Street", style: TextStyle(color: Colors.white)),
                          SizedBox(height: 8),
                          Text("Hi hepa!", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage("assets/images/avatar.png"),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const Text("Services:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _ServiceItem(image: "assets/images/burger.png", label: "Up to 50%", title: "Food"),
                    _ServiceItem(image: "assets/images/health.png", label: "20 mins", title: "Health & wellness"),
                    _ServiceItem(image: "assets/images/Groceries.png", label: "15 mins", title: "Groceries"),
                  ],
                ),

                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.grey.shade200, blurRadius: 6, offset: const Offset(0, 2))
                    ],
                  ),
                  child: Row(
                    children: [
                      Image.asset("assets/images/vault.png", height: 50),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Got a code !", style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("Add your code and save on your order", style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 24),
                const Text("Shortcuts:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    _Shortcut(imagePath: 'assets/images/past.png', label: 'Past orders'),
                    _Shortcut(imagePath: 'assets/images/best.png', label: 'Super Saver'),
                    _Shortcut(imagePath: 'assets/images/must.png', label: 'Must-tries'),
                    _Shortcut(imagePath: 'assets/images/give.png', label: 'Give Back'),
                    _Shortcut(imagePath: 'assets/images/best.png', label: 'Best Sellers'),
                  ],
                ),

                const SizedBox(height: 24),
                const ImageSlider(),
                const SizedBox(height: 24),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ProductError) {
                      return Center(child: Text(state.message));
                    } else if (state is ProductLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Products", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 12),
                          ...state.products.map((product) => Card(
                                child: ListTile(
                                  leading: Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                                  title: Text(product.name),
                                  subtitle: Text(product.description),
                                  trailing: Text('${product.price.toStringAsFixed(2)}'),
                                ),
                              )),
                        ],
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 24),
                const Text("Popular restaurants nearby", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _restaurantItem("Allo Beirut", "assets/images/Allo.png", "32 mins"),
                      _restaurantItem("Laffah", "assets/images/laffah.png", "38 mins"),
                      _restaurantItem("Falafil Al Rabiah Al kh...", "assets/images/falafl.png", "44 mins"),
                      _restaurantItem("Barbar", "assets/images/barber.png", "34 mins"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final String image;
  final String label;
  final String title;

  const _ServiceItem({required this.image, required this.label, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset(image),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
        ),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _Shortcut extends StatelessWidget {
  final String imagePath;
  final String label;
  const _Shortcut({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFFEEEEE),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.asset(imagePath),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}

Widget _restaurantItem(String name, String image, String time) {
  return Container(
    margin: const EdgeInsets.only(right: 16),
    width: 90,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: Colors.grey.shade200,
            child: Image.asset(image, height: 60, width: 60, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          name,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.access_time, size: 12, color: Colors.grey),
            const SizedBox(width: 4),
            Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ],
    ),
  );
}

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> bannerImages = List.generate(
    5,
    (_) => "assets/images/slider.png",
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemCount: bannerImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  bannerImages[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(bannerImages.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.deepPurple
                    : Colors.deepPurple.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}
