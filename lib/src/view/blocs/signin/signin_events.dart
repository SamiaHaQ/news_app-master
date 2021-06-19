import 'package:flutter/foundation.dart';

abstract class SignInEvent {}

class SignInOnUserAccount extends SignInEvent {
  final String email, password;
  SignInOnUserAccount({@required this.email, @required this.password});
}
