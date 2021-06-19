import 'package:flutter/foundation.dart';

abstract class ProfileEvent {}

class ProfileFetchEvent extends ProfileEvent {}

class ProfileChangeUsernameEvent extends ProfileEvent {
  final String userName;
  ProfileChangeUsernameEvent({@required this.userName});
}