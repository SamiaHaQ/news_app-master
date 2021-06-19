
import 'package:flutter/foundation.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordFailedState extends ForgotPasswordState {
  final String message;
  ForgotPasswordFailedState({@required this.message});
}

class ForgotPasswordErrorState extends ForgotPasswordState {}

class ForgotPasswordSuccessState extends ForgotPasswordState {}