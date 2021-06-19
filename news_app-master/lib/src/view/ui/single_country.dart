import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/src/business_logic/models/corona_country_data_model.dart';
import 'package:news_app/src/view/utils/reuseable_widgets.dart';
import 'package:pie_chart/pie_chart.dart';

class SingleCountry extends StatefulWidget {
  SingleCountry({@required this.country});

  final CountryDataModel country;

  @override
  _SingleCountryState createState() => _SingleCountryState();
}

class _SingleCountryState extends State<SingleCountry> {

  Map<String, double> dataMap;

  @override
  void initState() {
    super.initState();
    dataMap = {
      "Affected": widget.country.cases+ 0.0,
      "Recovered": widget.country.recovered+ 0.0,
      "Deaths": widget.country.deaths+ 0.0,
      "Active": widget.country.active+ 0.0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black87
        ),
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Container(
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${widget.country.countryInfo.flag}'),
                  )
              ),
            ),
            Text(
              '${widget.country.country}',
              style: TextStyle(
                  color: Colors.black87
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 15),
          PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            colorList: [
              Colors.red,
              Colors.green,
              Colors.orange,
              Colors.purple,
            ],
            chartType: ChartType.ring,
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      RichTextLabel(
                        name: 'Total Cases: ',
                        value: widget.country.cases.toString(),
                      ),
                      Divider(
                        height: 3,
                      ),
                      RichTextLabel(
                        name: 'Total Death: ',
                        value: widget.country.deaths.toString(),
                      ),
                      Divider(
                        height: 3,
                      ),
                      RichTextLabel(
                        name: 'Recovered: ',
                        value: widget.country.recovered.toString(),
                      ),
                      Divider(
                        height: 3,
                      ),
                      RichTextLabel(
                        name: 'Today\'s Cases: ',
                        value: widget.country.todayCases.toString(),
                      ),
                      Divider(
                        height: 3,
                      ),
                      RichTextLabel(
                        name: 'Today\'s Deaths: ',
                        value: widget.country.todayDeaths.toString(),
                      ),
                      Divider(
                        height: 3,
                      ),
                      RichTextLabel(
                        name: 'Tests Per Million: ',
                        value: widget.country.testsPerOneMillion.toString(),
                      ),
                      Divider(
                        height: 3,
                      ),
                      RichTextLabel(
                        name: 'Recovered Per Million: ',
                        value: widget.country.recoveredPerOneMillion.toString(),
                      ),
                      Divider(
                        height: 3,
                      ),
                      RichTextLabel(
                        name: 'Cases Per Million: ',
                        value: widget.country.casesPerOneMillion.toString(),
                      ),
                      Divider(
                        height: 3,
                      ),
                      RichTextLabel(
                        name: 'Deaths Per Million: ',
                        value: widget.country.deathsPerOneMillion.toString(),
                      ),
                      Divider(
                        height: 3,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              width: double.infinity,
              color: Colors.grey[500],
              height: 70,
              alignment: Alignment.center,
              child: Text(
                'Back',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
