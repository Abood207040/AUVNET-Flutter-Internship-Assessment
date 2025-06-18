import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth;

  LoginBloc(this._auth) : super(LoginState.initial()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email, error: null));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password, error: null));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(isSubmitting: true, error: null, isSuccess: false));
      try {
        await _auth.signInWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
        emit(state.copyWith(isSubmitting: false, isSuccess: true));
      } catch (e) {
        emit(state.copyWith(
          isSubmitting: false,
          error: "Login failed. Please check your credentials.",
          isSuccess: false,
        ));
      }
    });
  }
}
