import 'package:flutter/material.dart';

import 'package:common_utils_v2/common_utils_v2.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart' as WV;

/// 基于 flutter_webview_plugin插件
class WebviewPluginPage extends StatefulWidget {
  @override
  State<WebviewPluginPage> createState() => _WebviewPluginPageState();
}

class _WebviewPluginPageState extends State<WebviewPluginPage> {
  String path = "";
  String title = "";

  double lineProgress = 0.0;

  WV.FlutterWebviewPlugin flutterWebviewPlugin = WV.FlutterWebviewPlugin();


  @override
  void initState() {
    super.initState();
    path = Get.arguments["path"];
    title = Get.arguments["title"];
    setState(() {});

    flutterWebviewPlugin.onProgressChanged.listen((progress) {
      setState(() {
        lineProgress = progress;
      });
    });
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WV.WebviewScaffold(
      appBar: CommonAppBar.show(title, bottom: PreferredSize(child: _progressBar(lineProgress, context), preferredSize: const Size.fromHeight(3.0),)),
      useWideViewPort: true,
      withOverviewMode: true,
      withZoom: true,
      url: path,
      withJavascript: true,
      javascriptChannels: {
        WV.JavascriptChannel(
          name: 'RouterBackInterceptorClose',
          onMessageReceived: (WV.JavascriptMessage message) {
            /// ToastUtil.show("操作成功");
            Get.back();
          },
        ),
      }
    );
  }


  /// 动态进度条
  _progressBar(double progress, BuildContext context) {
    return LinearProgressIndicator(
      backgroundColor: Colors.white70.withOpacity(0),
      value: progress == 1.0 ? 0 : progress,
      minHeight: 2,
      valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
    );
  }
}
