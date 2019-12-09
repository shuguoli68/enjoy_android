import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebWidget extends StatelessWidget{

  final String url;
  final String title;

  const WebWidget({Key key,this.url,this.title}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title.isNotEmpty?title:'WebView'),
      ),
      url: url,
    );
  }


}