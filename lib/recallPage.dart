import 'package:flutter/material.dart';
import 'package:service_app/main.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

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
        centerTitle: true,
        backgroundColor: darkBlue,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Vehicle Recall Lookup', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: RecallWebPage(),
    );
  }
}

class RecallWebPage extends StatelessWidget {
  final String website = 'https://www.nhtsa.gov/recalls';

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.android) {
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
          ..loadRequest(Uri.parse(website)
        )
      );
    } 
    else {
      openUrl(website); 
      return const Align(
        alignment: Alignment.center, 
        child: Text("Launched Website!", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))
      );
    }
  }

  void openUrl(site) async {
    final Uri url = Uri.parse(site);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
