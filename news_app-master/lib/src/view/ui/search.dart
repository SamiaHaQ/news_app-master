import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/view/blocs/search/search_bloc.dart';
import 'package:news_app/src/view/blocs/search/search_events.dart';
import 'package:news_app/src/view/blocs/search/search_states.dart';
import 'package:news_app/src/view/utils/constants.dart';
import 'package:news_app/src/view/utils/reuseable_widgets.dart';

import 'news_details.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String query;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchBloc>(context).add(SearchGetAllHeadlineEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(50),
                child: TextField(
                  onChanged: (text){
                    this.query = text;
                  },
                  decoration: InputDecoration(
                      hintText: 'Search news',
                      suffixIcon: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(50),
                        child: IconButton(
                          icon: Icon(Icons.search,
                              color: Colors.black87),
                          onPressed: (){
                            if (query.trim().length > 2) {
                              BlocProvider.of<SearchBloc>(context).add(SearchSearchNewsByQueryEvent(query: this.query));
                            } else {
                              BotToast.showText(text: 'Must be more than 2 letters', contentColor: Colors.red, textStyle: TextStyle(color: kWhiteColor));
                            }
                          },
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 30),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none
                      )
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder(
                  bloc: BlocProvider.of<SearchBloc>(context),
                  builder: (context, state){
                    if (state is SearchNewsLoadingState){
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SearchNewsErrorState){
                      return Center(child: Text("Something went wring!"),);
                    } else if (state is SearchNewsFetchedSuccessState){
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
