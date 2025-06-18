import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/data/datasources/hive_helper.dart';
import 'package:task/presentation/onboarding/onboarding_bloc.dart';
import 'package:task/presentation/onboarding/onboarding_event.dart';
import 'package:task/presentation/onboarding/onboarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  final List<Map<String, String>> pages = [
    {
      "image": "assets/images/onboarding.png",
      "title": "all-in-one delivery",
      "description":
          "Order groceries, medicines, and meals delivered straight to your door",
    },
    {
      "image": "assets/images/onboarding.png",
      "title": "User-to-User Delivery",
      "description":
          "Send or receive items from other users quickly and easily",
    },
    {
      "image": "assets/images/onboarding.png",
      "title": "Sales & Discounts",
      "description": "Discover exclusive sales and deals every day",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingBloc(),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            if (state.completed) {
              Future.microtask(() async {
                await HiveHelper.setOnboardingSeen(true);
                Navigator.pushReplacementNamed(context, "/login");
              });
              return const SizedBox.shrink();
            }

            return Column(
              children: [
                Expanded(
                  flex: 5,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      context.read<OnboardingBloc>().add(OnboardingNextPage());
                    },
                    itemBuilder: (_, index) {
                      final data = pages[index];
                      return Column(
                        children: [
                          SizedBox(
                            height: 220,
                            child: Center(
                              child: Image.asset(
                                'assets/images/nawel.png',
                                width: 180,
                                height: 180,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Text(
                              data['title']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: Text(
                              data['description']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF7B1FA2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                ),
                                onPressed: () {
                                  if (index == pages.length - 1) {
                                    context.read<OnboardingBloc>().add(
                                      OnboardingSkip(),
                                    );
                                  } else {
                                    _pageController.nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                                child: const Text(
                                  'Get Started',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (index < pages.length - 1)
                            GestureDetector(
                              onTap: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: const Text(
                                'next',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
