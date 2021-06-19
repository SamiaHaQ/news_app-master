import 'package:flutter/foundation.dart';
import 'package:news_app/src/business_logic/models/news_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeNewsLoadingState extends HomeState {}

class HomeNewsErrorState extends HomeState {}

class HomeNewsFailedState extends HomeState {
  final String message;
  HomeNewsFailedState({@required this.message});
}

class HomeNewsFetchedSuccessState extends HomeState {
  final NewsModel newsModel;
  HomeNewsFetchedSuccessState({@required this.newsModel});
}