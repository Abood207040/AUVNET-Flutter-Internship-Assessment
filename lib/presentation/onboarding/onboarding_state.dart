class OnboardingState {
  final int currentPage;
  final bool completed;

  OnboardingState({required this.currentPage, this.completed = false});

  OnboardingState copyWith({int? currentPage, bool? completed}) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      completed: completed ?? this.completed,
    );
  }
}
