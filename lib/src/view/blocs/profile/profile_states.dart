import 'package:flutter/foundation.dart';
import 'package:news_app/src/business_logic/models/user.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileErrorState extends ProfileState {}

class ProfileFailedState extends ProfileState {}

class ProfileUserNameChangedSuccessState extends ProfileState {}

class ProfileDataFetchedState extends ProfileState {
  final User user;
  ProfileDataFetchedState({@required this.user});
}