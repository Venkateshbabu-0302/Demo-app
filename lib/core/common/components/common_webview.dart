import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebView extends StatefulWidget {
  final String url;
  final String title;
  CommonWebView({required this.url, required this.title});
  @override
  _CommonWebViewState createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: WebView(
    initialUrl: widget.url!
),
    );

    
  }
}
