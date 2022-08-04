
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';



const String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head><title>Navigation Delegate Example</title></head>
<body>
<p>
The navigation delegate is set to block navigation to the youtube website.
</p>
<ul>
<ul><a href="https://www.youtube.com/">https://www.youtube.com/</a></ul>
<ul><a href="https://www.google.com/">https://www.google.com/</a></ul>
</ul>
</body>
</html>
''';

const String kLocalExamplePage = '''
<!DOCTYPE html>
<html lang="en">
<head>
<title>Load file or HTML string example</title>
</head>
<body>

<h1>Local demo page</h1>
<p>
  This is an example page used to demonstrate how to load a local file or HTML
  string using the <a href="https://pub.dev/packages/webview_flutter">Flutter
  webview</a> plugin.
</p>

</body>
</html>
''';

const String kTransparentBackgroundPage = '''
  <!DOCTYPE html>
  <html>
  <head>
    <title>Transparent background test</title>
  </head>
  <style type="text/css">
    body { background: transparent; margin: 0; padding: 0; }
    #container { position: relative; margin: 0; padding: 0; width: 100vw; height: 100vh; }
    #shape { background: red; width: 200px; height: 200px; margin: 0; padding: 0; position: absolute; top: calc(50% - 100px); left: calc(50% - 100px); }
    p { text-align: center; }
  </style>
  <body>
    <div id="container">
      <p>Transparent background test</p>
      <div id="shape"></div>
    </div>
  </body>
  </html>
''';

class Web_View extends StatefulWidget {
  const Web_View({Key? key, this.cookieManager, this.initialUrl}) : super(key: key);

  final CookieManager? cookieManager;
  final String? initialUrl;

  @override
  State<Web_View> createState() => _Web_ViewState();

}

class _Web_ViewState extends State<Web_View >  with WidgetsBindingObserver{

  double? _webViewHeight;
  // is true while a page loading is in progress
  bool _isPageLoading = true;

  @override
  void initState() {
    super.initState();
    // add listener to detect orientation change
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    // remove listener
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    // on portrait / landscape or other change, recalculate height
    _setWebViewHeight();
  }



  int progress=0;
  bool Loading=true;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  late WebViewController controllerGlobal;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
      title: InkWell(
          onTap: (){
            controllerGlobal.loadUrl("${widget.initialUrl}");
          },child: Image.asset("assets/logo.png",width: 100,)),
      centerTitle: true,
      leading:IconButton(onPressed: (){
        controllerGlobal.clearCache();
      }, icon: Icon(Icons.refresh),),
      actions: [
      ],),
      body: WillPopScope(
        onWillPop: () => _exitApp(context),
        child:Stack(
          children: [
            RefreshIndicator(
              onRefresh: refreshCollectionItems,
              color: Colors.deepOrangeAccent,

              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                //  height: _webViewHeight,

                  child: WebView(
                    initialUrl: widget.initialUrl,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      setState(() {
                        controllerGlobal=webViewController;
                      });
                      _controller.complete(webViewController);
                      controllerGlobal.clearCache();

                    },

                      onPageStarted: (String url) {
                        setState(() {
                          _isPageLoading = true;
                        });
                      },
                      onPageFinished: (String url) {
                        setState(() {
                          _isPageLoading = false;
                        });
                        // if page load is finished, set height
                        _setWebViewHeight();
                      },


                    onProgress: (int progress) {
                      setState(() {
                        this.progress=progress;
                        Loading=progress!=100;
                      });
                      print('WebView is loading (progress : $progress%)');
                    },
                    javascriptChannels: <JavascriptChannel>{
                      _toasterJavascriptChannel(context),
                    },
                    navigationDelegate: (NavigationRequest request) {
                      if (request.url.startsWith('https://www.youtube.com/')) {
                        print('blocking navigation to $request}');
                        return NavigationDecision.prevent;
                      }
                      print('allowing navigation to $request');
                      return NavigationDecision.navigate;
                    },

                    gestureNavigationEnabled: true,
                    backgroundColor: const Color(0x00000000),


                  ),
                ),
              ),
            ),
            Loading?Container(
                color: Colors.white,child: Stack(
              children: [
                Center(child: Text("$progress %",style: TextStyle(fontSize: 20,color: Colors.deepOrangeAccent,backgroundColor: Colors.white),)),
                Center(child: Image.asset("assets/splash.gif")),
              ],
            )):Container()
          ],
        ),

      ),
    );
  }

  Future<void> refreshCollectionItems() async {
    setState(() {
      controllerGlobal.reload();
      print('good');
    });
  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  Widget favoriteButton() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          return FloatingActionButton(
            onPressed: () async {
              String? url;
              if (controller.hasData) {
                url = await controller.data!.currentUrl();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    controller.hasData
                        ? 'Favorited $url'
                        : 'Unable to favorite',
                  ),
                ),
              );
            },
            child: const Icon(Icons.favorite),
          );
        });
  }

  _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      print("onwill goback");
      // _controller.future.then((value) => value.goBack());
      controllerGlobal.goBack();
      //return Future.value(true);
    } else {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 90,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Do you want to exit?"),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('yes selected');
                              exit(0);
                            },
                            child: Text("Yes"),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.orange.shade800),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                print('no selected');
                                Navigator.of(context).pop();
                              },
                              child: Text("No", style: TextStyle(color: Colors.black)),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                              ),
                            ))
                      ],
                    )
                  ],
                ),
              ),
            );
          });
      return Future.value(false);
    }
  }

  void _setWebViewHeight() {
    // we don't update if WebView is not ready yet
    // or page load is in progress
    if (controllerGlobal == null || _isPageLoading) {
      return;
    }
    // execute JavaScript code in the loaded page
    // to get body height
    controllerGlobal
        .evaluateJavascript('document.body.clientHeight')
        .then((documentBodyHeight) {
      // set height
      setState(() {
        print('WebView height set to: $documentBodyHeight');
        _webViewHeight = double.parse(documentBodyHeight);
      });
    });
  }

}

enum MenuOptions {
  showUserAgent,
  listCookies,
  clearCookies,
  addToCache,
  listCache,
  clearCache,
  navigationDelegate,
  doPostRequest,
  loadLocalFile,
  loadFlutterAsset,
  loadHtmlString,
  transparentBackground,
  setCookie,
}