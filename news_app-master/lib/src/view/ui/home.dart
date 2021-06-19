import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/business_logic/services/news_api_services/news_api_services.dart';
import 'package:news_app/src/view/blocs/home/home_bloc.dart';
import 'package:news_app/src/view/blocs/home/home_events.dart';
import 'package:news_app/src/view/blocs/home/home_states.dart';
import 'package:news_app/src/view/ui/filter.dart';
import 'package:news_app/src/view/utils/reuseable_widgets.dart';

import 'news_details.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var countryList = [];
  var countryCodeList = [];


  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeGetAllHeadlineEvent());
    // ignore: missing_return

  }

  Widget setupAlertDialoadContainer() {

    return Container(
      height: 300.0, // Change as per your requirement
      width: 300.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: countryList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(countryCodeList[index]),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Top Headlines', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Chip(label: Text(NewsAPIServices.country),),
                          SizedBox(width: 10,),
                          Chip(label: Text(NewsAPIServices.category),),
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => Filter()
                      ));
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder(
                  bloc: BlocProvider.of<HomeBloc>(context),
                  builder: (context, state){
                    if (state is HomeNewsLoadingState){
                      return Center(child: CircularProgressIndicator());
                    } else if (state is HomeNewsErrorState){
                      return Center(child: Text("Something went wrong!"),);
                    } else if (state is HomeNewsFetchedSuccessState){
                      return ListView.builder(
                          itemCount: state.newsModel.articles.length,
                          itemBuilder: (context, index){
                            return NewsCard(
                              title: state.newsModel.articles[index].title,
                              publishedAt: state.newsModel.articles[index].publishedAt,
                              imageUrl: state.newsModel.articles[index].urlToImage,
                              description: state.newsModel.articles[index].description,
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => NewsDetails(article: state.newsModel.articles[index])
                                ));
                              },
                            );
                          }
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


