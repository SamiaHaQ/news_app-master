import 'package:news_app/src/business_logic/services/news_api_services/news_api_services.dart';

main() async{
  var value = await NewsAPIServices.getTopHeadline();
  value.articles.forEach((element) { print(element.author);});
}