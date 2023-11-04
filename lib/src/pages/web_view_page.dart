import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'package:common_utils_v2/common_utils_v2.dart';

/// 基于webview_flutter插件
class WebviewPage extends StatefulWidget {
  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  WebViewController controller = WebViewController();
  String path = "";
  String title = "";

  @override
  void initState() {
    super.initState();
    // TODO: 待实际测试
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    controller = WebViewController.fromPlatformCreationParams(params);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController).setMediaPlaybackRequiresUserGesture(false);
    }

    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(const Color(0x00000000));
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {
          controller.runJavaScript(""" """);
        },
        onPageFinished: (String url) {
          controller.runJavaScript(""" """);
        },
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
    controller.loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar.show(title),
      body: WebViewWidget(
        // javascriptMode: JavascriptMode.unrestricted,
        // onWebViewCreated: (WebViewController webViewController) {
        //   _controller.complete(webViewController);
        // },
        // onPageStarted: (String url) {
        //   _webViewController.evaluateJavascript(""" """);
        // },
        // onPageFinished: (String url) {
        //   _webViewController.evaluateJavascript("""  """);
        // },
        // javascriptChannels: {JavascriptChannel(name: "postMessage", onMessageReceived: (message) {})},
        controller: controller,
      ),
    );
  }
}
