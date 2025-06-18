import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final FirebaseAuth _auth;

  SignupBloc(this._auth) : super(SignupInitial()) {
    on<SignupSubmitted>((event, emit) async {
      emit(SignupLoading());

      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email.trim(),
          password: event.password.trim(),
        );

        await userCredential.user!.updateDisplayName(event.name.trim());

        emit(SignupSuccess());
      } catch (e) {
        emit(SignupFailure("Signup failed. Try again."));
      }
    });
  }
}
