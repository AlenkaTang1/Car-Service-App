import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RecallPage extends StatefulWidget {
  const RecallPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RecallPageState();
}

class _RecallPageState extends State<RecallPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Recall Lookup'),
      ),
      body: RecallWebPage(),
    );
  }
}

class RecallWebPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return WebViewWidget(
      controller: WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {},
            onWebResourceError: (WebResourceError error) {},
          ),
        )
        ..loadRequest(Uri.parse('https://www.nhtsa.gov/recalls'))
    );
  }
}
