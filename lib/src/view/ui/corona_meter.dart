import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:news_app/src/business_logic/models/all_data_model.dart';
import 'package:news_app/src/business_logic/models/corona_country_data_model.dart';
import 'package:news_app/src/business_logic/services/repository.dart';
import 'package:news_app/src/view/ui/single_country.dart';
import '../utils/constants.dart';

class CoronaMeter extends StatefulWidget {
  @override
  _CoronaMeterState createState() => _CoronaMeterState();
}

class _CoronaMeterState extends State<CoronaMeter> {
  AllData allData;
  bool inProgress = false;
  List<CountryDataModel> _countries = [];
  List<CountryDataModel> _countriesData = [];

  @override
  void initState() {
    super.initState();
    allData = AllData();
    getAllData();
  }

  getAllData() async {
    setState(() {
      inProgress = true;
    });
    _countries.clear();
    allData = await repository.getAllData();
    final _response = await repository.getAllCountryData();
    for (var res in _response) {
      CountryDataModel country = CountryDataModel(
          country: res['country'],
          countryInfo: CountryInfo(
            flag: res['countryInfo']['flag'],
          ),
          cases: res['cases'],
          todayCases: res['todayCases'],
          deaths: res['deaths'],
          todayDeaths: res['todayDeaths'],
          todayRecovered: res['todayRecovered'],
          recovered: res['recovered'],
          tests: res['tests'],
          active: res['active'],
          critical: res['critical'],
        activePerOneMillion: res['activePerOneMillion'] + 0.0,
        casesPerOneMillion: res['casesPerOneMillion']+0.0,
        deathsPerOneMillion: res['deathsPerOneMillion']+0.0,
        testsPerOneMillion: res['testsPerOneMillion']+0.0,
        recoveredPerOneMillion: res['recoveredPerOneMillion']+0.0,
      );
      _countries.add(country);
    }
    setState(() {
      _countriesData = _countries;
      inProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kDarkBlueColor,
        body: ModalProgressHUD(
          inAsyncCall: inProgress,
          color: kDarkBlueColor,
          child: SafeArea(
              child: Column(
            children: <Widget>[
              Container(
                height: 65,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Corona Meter',
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.refresh,
                          color: kWhiteColor,
                        ),
                        onPressed: () {
                          getAllData();
                        },
                      )
                    ],
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(25)),
                child: Container(
                  height: MediaQuery.of(context).size.height - 152.7,
                  width: MediaQuery.of(context).size.width,
                  color: kWhiteColor,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: <Widget>[
                              Card(
                                elevation: 3,
                                child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text('CASES',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kDarkBlueColor)),
                                      Divider(
                                          color: kBlackColor,
                                          endIndent: 8,
                                          indent: 8),
                                      Text(
                                          allData.cases == null
                                              ? '00'
                                              : '${allData.cases}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kBlackColor,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 3,
                                child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('DEATHS',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kDarkBlueColor)),
                                      Divider(
                                          color: kBlackColor,
                                          endIndent: 8,
                                          indent: 8),
                                      Text(
                                          allData.deaths == null
                                              ? '00'
                                              : '${allData.deaths}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kBlackColor,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 3,
                                child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('ACTIVE',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kDarkBlueColor)),
                                      Divider(
                                          color: kBlackColor,
                                          endIndent: 8,
                                          indent: 8),
                                      Text(
                                          allData.active == null
                                              ? '00'
                                              : '${allData.active}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kBlackColor,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 3,
                                child: Container(
                                  padding: const EdgeInsets.all(12.0),
                                  width: 150,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text('RECOVERED',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: kDarkBlueColor)),
                                      Divider(
                                          color: kBlackColor,
                                          endIndent: 8,
                                          indent: 8),
                                      Text(
                                          allData.recovered == null
                                              ? '00'
                                              : '${allData.recovered}',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: kBlackColor,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Container(
                          child: ListView.builder(
                            itemCount: _countriesData.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SingleCountry(country: _countriesData[index])));
                                  },
                                  leading: Image.network(
                                    '${_countriesData[index].countryInfo.flag}',
                                    width: 50,
                                  ),
                                  title:
                                      Text('${_countriesData[index].country}'),
                                  subtitle: Text(
                                      'Cases : ${_countriesData[index].cases}\nDeaths : ${_countriesData[index].deaths}\nRecovered : ${_countriesData[index].recovered}  '),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
        ));
  }
}
