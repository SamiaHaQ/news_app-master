import 'package:flutter/foundation.dart';

abstract class ForgotPasswordEvent {}

class ForgotPasswordResetEvent extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordResetEvent({@required this.email});
}