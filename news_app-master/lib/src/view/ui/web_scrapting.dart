import 'dart:core';

import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(WebScraperApp());

class WebScraperApp extends StatefulWidget {
  @override
  _WebScraperAppState createState() => _WebScraperAppState();
}

class _WebScraperAppState extends State<WebScraperApp> {
  List<NewsModel> newsList = List<NewsModel>();
  bool loading = false;

  // initialize WebScraper by passing base url of website
  final webScraper = WebScraper('https://www.prothomalo.com/');

  // Response of getElement is always List<Map<String, dynamic>>

  void fetchProducts() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    newsList.clear();
    // Loads web page and downloads into local state of library
    if (await webScraper
        .loadWebPage('')) {
      final listOfNews = webScraper.getElement(
            'div.news_with_no_image > h2.headline-title > a.newsHeadline-m__title-link__1puEG', ['href']);
      listOfNews.forEach((element) {
        newsList.add(NewsModel.fromJson(element));
      });
    }
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Requesting to fetch before UI drawing starts
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: Text('Bangla News'),
          ),
      body: loading ? Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
          itemCount: newsList.length,
          itemBuilder: (context, index) {
            return Card(
              margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ListTile(
                contentPadding: EdgeInsets.all(12),
                onTap: () async {
                  // await launch(newsList[index].attributes.href);
                },
                title: Text(newsList[index].title),
                subtitle: Text(newsList[index].attributes.href, style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400
                ),),
                trailing: Icon(Icons.arrow_forward),
              ),
            );
      }),
    );
  }
}

class NewsModel {
  String title;
  Attributes attributes;

  NewsModel({this.title, this.attributes});

  NewsModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.toJson();
    }
    return data;
  }
}

class Attributes {
  String href;

  Attributes({this.href});

  Attributes.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
