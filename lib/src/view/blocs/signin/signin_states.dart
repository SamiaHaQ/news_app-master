import 'package:flutter/foundation.dart';

abstract class SignInState {}

class SignInInitialState extends SignInState {}

class SignInLoadingState extends SignInState {}

class SignInErrorState extends SignInState {}

class SignInFailedState extends SignInState {
  final String message;
  SignInFailedState({@required this.message});
}

class SignInSuccessState extends SignInState {}
