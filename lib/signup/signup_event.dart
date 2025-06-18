abstract class SignupEvent {}

class SignupSubmitted extends SignupEvent {
  final String name;
  final String email;
  final String password;

  SignupSubmitted(this.name, this.email, this.password);
}
