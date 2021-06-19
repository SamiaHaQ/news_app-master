import 'package:flutter/foundation.dart';

abstract class HomeEvent {}

class HomeGetAllHeadlineEvent extends HomeEvent {}

class HomeSearchNewsByQueryEvent extends HomeEvent {
  final String query;
  HomeSearchNewsByQueryEvent({@required this.query});
}