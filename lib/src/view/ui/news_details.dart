import 'package:flutter/material.dart';
import 'package:news_app/src/business_logic/models/news_model.dart';
import 'package:news_app/src/view/ui/webview_screen.dart';
import 'package:news_app/src/view/utils/constants.dart';

class NewsDetails extends StatelessWidget {
  NewsDetails({@required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20),),
                          child: SizedBox(
                            height: 280,
                            width: MediaQuery.of(context).size.width,
                            child: FadeInImage(
                              placeholder: AssetImage('assets/images/news.png'),
                              image: NetworkImage(article.urlToImage),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        BackButton()
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
                      child: Text(
                        article.title,
                        style: TextStyle(
                            color: kSoftBlackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 8, left: 16),
                      child: Row(
                        children: <Widget>[
                          Chip(
                            label: Text('${article.publishedAt.split("T")[1]+"  "+article.publishedAt.split("T")[0]}', style: TextStyle(color: kWhiteColor, fontSize: 12, fontWeight: FontWeight.w500),),
                            backgroundColor: kDarkBlueColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(article.description, style: TextStyle(fontSize: 15),),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      alignment: Alignment.centerLeft,
                      child: Text(article.author),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => WebViewScreen(url: article.url, title: article.title)
                ));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                color: kDarkBlueColor,
                alignment: Alignment.center,
                child: Text(
                  'Read more',
                  style: TextStyle(
                    fontSize: 20,
                    color: kWhiteColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
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
