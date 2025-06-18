import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../../../data/datasources/hive_helper.dart';

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashNavigate extends SplashState {
  final String route;
  SplashNavigate(this.route);
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> checkOnboarding() async {
    await Future.delayed(const Duration(seconds: 2));
    final seen = HiveHelper.getOnboardingSeen();

    if (seen) {
      emit(SplashNavigate('/login'));
    } else {
      emit(SplashNavigate('/onboarding'));
    }
  }
}
