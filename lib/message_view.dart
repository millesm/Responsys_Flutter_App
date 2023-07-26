import 'package:flutter/material.dart';

import 'package:webview_flutter/webview_flutter.dart';

class MessageView extends StatefulWidget {
  const MessageView({key, this.payload});
  final String payload;

  @override
  State<MessageView> createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  WebViewController controller;

  _MessageViewState();

  @override
  void initState() {
    super.initState();
    controller = WebViewController()..loadHtmlString(widget.payload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: const Text('Flutter WebView'),
          ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
