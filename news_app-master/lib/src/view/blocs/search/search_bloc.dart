import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/business_logic/services/repository.dart';
import 'package:news_app/src/view/blocs/search/search_events.dart';
import 'package:news_app/src/view/blocs/search/search_states.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc(SearchState initialState) : super(initialState);

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async*{
    if (event is SearchGetAllHeadlineEvent) {
      yield SearchNewsLoadingState();
      try {
        var _response = await repository.getAllHeadline;
        yield SearchNewsFetchedSuccessState(newsModel: _response);
      } catch (error){
        yield SearchNewsErrorState();
      }
    } else if (event is SearchSearchNewsByQueryEvent){
      yield SearchNewsLoadingState();
      try {
        var _response = await repository.searchNews(event.query);
        yield SearchNewsFetchedSuccessState(newsModel: _response);
      } catch (error){
        yield SearchNewsErrorState();
      }
    }
  }

}