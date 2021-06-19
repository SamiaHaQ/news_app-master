import 'package:news_app/src/business_logic/models/all_data_model.dart';
import 'package:news_app/src/business_logic/models/news_model.dart';
import 'package:news_app/src/business_logic/services/corona_api_services/corona_api_services.dart';
import 'news_api_services/news_api_services.dart';

class _Repository {
  Future<NewsModel> get getAllHeadline => NewsAPIServices.getTopHeadline();
  Future<NewsModel> searchNews(String query) => NewsAPIServices.getEveryThingSearchNews(query);
  Future<AllData> getAllData() => NewsAPIServices.getAllData();
  Future getAllCountryData() => CoronaAPIServices.getAllCountryData();
}
final repository = _Repository();