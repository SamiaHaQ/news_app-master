import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:news_app/src/view/utils/constants.dart';

class WebViewScreen extends StatelessWidget {
  WebViewScreen({@required this.url, @required this.title});
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  final String url, title;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: url,
      mediaPlaybackRequiresUserGesture: false,
      appBar: AppBar(
        backgroundColor: kSoftGreenColor,
        title: Text(title),
      ),
      withZoom: true,
      withLocalStorage: true,
      hidden: true,
      initialChild: Container(
        color: kWhiteColor,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                flutterWebViewPlugin.goBack();
              },
            ),
            IconButton(
              icon: const Icon(Icons.autorenew),
              onPressed: () {
                flutterWebViewPlugin.reload();
              },
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward_ios),
              onPressed: () {
                flutterWebViewPlugin.goForward();
              },
            ),

          ],
        ),
      ),
    );
  }
}
