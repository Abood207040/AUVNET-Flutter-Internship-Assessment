class LoginState {
  final String email;
  final String password;
  final bool isSubmitting;
  final String? error;
  final bool isSuccess;

  LoginState({
    required this.email,
    required this.password,
    required this.isSubmitting,
    this.error,
    this.isSuccess = false,
  });

  factory LoginState.initial() => LoginState(
        email: '',
        password: '',
        isSubmitting: false,
        error: null,
        isSuccess: false,
      );

  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    String? error,
    bool? isSuccess,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
