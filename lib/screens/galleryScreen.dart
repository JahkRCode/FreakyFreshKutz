import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:freakyfreshkutz/constants/constants.dart' as Constants;
import 'package:freakyfreshkutz/constants/vconstants.dart' as vConstants;

class Gallery extends StatelessWidget {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.THEME_BASE,
        title: Center(
            child: const Text(
          vConstants.SL_GALLERY,
          style: TextStyle(
            fontSize: 25,
            color: Constants.THEME_ONE,
            fontWeight: FontWeight.bold,
          ),
        )),
      ),
      body: Container(
        color: Constants.THEME_BASE,
        child: WebView(
          initialUrl: Constants.COMPANY_INSTAGRAM,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
        ),
      ),
    );
  }
}
