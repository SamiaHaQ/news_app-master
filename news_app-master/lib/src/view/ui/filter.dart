import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/business_logic/services/news_api_services/news_api_services.dart';
import 'package:news_app/src/view/blocs/home/home_bloc.dart';
import 'package:news_app/src/view/blocs/home/home_events.dart';
import '../utils/constants.dart';

class Filter extends StatefulWidget {

  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var button = "country";
  var country = NewsAPIServices.country;
  var category = NewsAPIServices.category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                BackButton(),
                Text('Filter headlines', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),)
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: button == 'country' ? Colors.black12 : null,
                    child: Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            button = "country";
                            setState(() {

                            });
                          },
                          child: Text('Country'),
                        ),
                        Chip(
                          label: Text(country),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: button != 'country' ? Colors.black12 : null,
                    child: Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            button = "category";
                            setState(() {

                            });
                          },
                          child: Text('Category'),
                        ),
                        Chip(
                          label: Text(category),
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
            Expanded(
              child: button == "country" ? ListView.builder(
                  itemCount: kCountryCode.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        setState(() {
                          country = kCountryCode[index];
                        });
                      },
                      title: Row(
                        children: <Widget>[
                          Chip(label: Text(kCountryCode[index], style: TextStyle(color: kDarkBlueColor),)),
                          SizedBox(width: 10),
                          Text(kCountries[index]),
                        ],
                      ),
                    );
                  }
              ) : ListView.builder(
                  itemCount: kCategoriesCode.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        setState(() {
                          category = kCategoriesCode[index];
                        });
                      },
                      title: Row(
                        children: <Widget>[
                          Chip(label: Text(kCategoriesCode[index], style: TextStyle(color: kDarkBlueColor),)),
                          SizedBox(width: 10),
                          Text(kCategories[index]),
                        ],
                      ),
                    );
                  }
              ),
            ),
            InkWell(
              onTap: (){
                NewsAPIServices.country = country;
                NewsAPIServices.category = category;
                BlocProvider.of<HomeBloc>(context).add(HomeGetAllHeadlineEvent());
                Navigator.pop(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                color: kDarkBlueColor,
                alignment: Alignment.center,
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: 0.4,
                    color: kWhiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
