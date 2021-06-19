import 'dart:convert';

import 'package:http/http.dart' as http;

const CORONA_BASE_API = 'https://disease.sh/v3/covid-19/countries';

class CoronaAPIServices {

  static Future<dynamic> getAllCountryData() async{
    try {
      final _response = await http.get(CORONA_BASE_API);
      if (_response.statusCode == 200) {
        print(_response.body);
        return jsonDecode(_response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}