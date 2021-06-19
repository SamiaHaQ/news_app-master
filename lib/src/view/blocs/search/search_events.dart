import 'package:flutter/foundation.dart';

abstract class SearchEvent {}

class SearchGetAllHeadlineEvent extends SearchEvent {}

class SearchSearchNewsByQueryEvent extends SearchEvent {
  final String query;
  SearchSearchNewsByQueryEvent({@required this.query});
}