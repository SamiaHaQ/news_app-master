import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/src/business_logic/models/all_data_model.dart';
import 'package:news_app/src/business_logic/models/news_model.dart';

const BASE_URL = "https://newsapi.org/v2/";
const API_KEY = "62bb1d14ea3d45f78157cd5af17dc9e5";
const CORONA_BASA_URL = 'https://www.disease.sh/v3/covid-19/';

class NewsAPIServices {
  static http.Client _client = http.Client();
  static String country = "us";
  static String language = "en";
  static String category = "general";


  // get all top headlines
  static Future<NewsModel> getTopHeadline() async{
    try {
      var _response = await _client.get("$BASE_URL/top-headlines?country=$country&category=$category&apiKey="+API_KEY);
      if (_response.statusCode == 200){
        return NewsModel.fromJson(jsonDecode(_response.body));
      } else {
        throw Exception('Something went wrong!');
      }
    } catch (_){
      throw Exception('Something went wrong!');
    }
  }

  // get news by search from every sources
  static Future<NewsModel> getEveryThingSearchNews(String query) async {
    try {
      var _response = await _client.get("$BASE_URL/everything?q=$query&apiKey="+API_KEY);
      if (_response.statusCode == 200){
        return NewsModel.fromJson(jsonDecode(_response.body));
      } else {
        throw Exception('Something went wrong!');
      }
    } catch (_){
      throw Exception('Something went wrong!');
    }
  }

  // get all data from api
  static Future<AllData> getAllData() async {
    try {
      var _response = await _client.get(CORONA_BASA_URL+'all');
      if (_response.statusCode == 200) {
        final decodedJson = jsonDecode(_response.body);
        return AllData(cases: decodedJson['cases'], deaths: decodedJson['deaths'], recovered: decodedJson['recovered'], active: decodedJson['active']);
      }
    } catch (error) {
      throw Exception(error.toString());
    }
  }
}