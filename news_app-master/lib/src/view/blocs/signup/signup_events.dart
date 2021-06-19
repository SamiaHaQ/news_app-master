import 'package:flutter/foundation.dart';

abstract class SignUpEvent {}

class SignUpToUserAccount extends SignUpEvent {
  final String email, password, userName;
  SignUpToUserAccount({@required this.email, @required this.password, @required this.userName});
}