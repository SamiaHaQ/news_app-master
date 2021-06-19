abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}
class SignUpLoadingState extends SignUpState {}
class SignUpErrorState extends SignUpState {}
class SignUpFailedState extends SignUpState {
  String message;
  SignUpFailedState({this.message});
}
class SignUpSuccessState extends SignUpState {}