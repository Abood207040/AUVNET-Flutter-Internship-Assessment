import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/data/datasources/hive_helper.dart';
import 'package:task/presentation/screens/onboarding_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'presentation/bloc/cart_bloc.dart';
import 'data/repositories/cart_repository_impl.dart';

import 'firebase_options.dart';
import 'presentation/screens/splash_screen.dart';

import 'presentation/screens/login_screen.dart';
import 'presentation/screens/signup_screen.dart';
import 'presentation/screens/home_screen.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ تهيئة Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ✅ تهيئة Hive
  await Hive.initFlutter();
  await HiveHelper.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: const NawelApp(),
    ),
  );
}

class NawelApp extends StatelessWidget {
  const NawelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nawel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // 👈 البداية من SplashScreen
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
