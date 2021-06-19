import 'package:flutter/foundation.dart';
import 'package:news_app/src/business_logic/models/news_model.dart';

abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchNewsLoadingState extends SearchState {}

class SearchNewsErrorState extends SearchState {}

class SearchNewsFailedState extends SearchState {
  final String message;
  SearchNewsFailedState({@required this.message});
}

class SearchNewsFetchedSuccessState extends SearchState {
  final NewsModel newsModel;
  SearchNewsFetchedSuccessState({@required this.newsModel});
}

class SearchEmptyState extends SearchState {}