import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_logic.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..checkOnboarding(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            Navigator.pushReplacementNamed(context, state.route);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 800),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/nawel.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'NAWEL',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7B1FA2), // purple
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
