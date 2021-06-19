import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/business_logic/services/repository.dart';

import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState) : super(initialState);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async*{
    if (event is HomeGetAllHeadlineEvent) {
      yield HomeNewsLoadingState();
      try {
        var _response = await repository.getAllHeadline;
        yield HomeNewsFetchedSuccessState(newsModel: _response);
      } catch (error){
        yield HomeNewsErrorState();
      }
    } else if (event is HomeSearchNewsByQueryEvent){
      yield HomeNewsLoadingState();
      try {
        var _response = await repository.searchNews(event.query);
        yield HomeNewsFetchedSuccessState(newsModel: _response);
      } catch (error){
        yield HomeNewsErrorState();
      }
    }
  }

}