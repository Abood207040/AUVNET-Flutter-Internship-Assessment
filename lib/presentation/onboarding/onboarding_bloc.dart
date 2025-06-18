import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState(currentPage: 0)) {
    on<OnboardingNextPage>((event, emit) {
      emit(state.copyWith(currentPage: state.currentPage + 1));
    });

    on<OnboardingSkip>((event, emit) {
      emit(state.copyWith(completed: true));
    });
  }
}
