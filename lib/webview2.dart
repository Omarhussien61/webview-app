import 'dart:async';
import 'dart:io';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:urwaypayment/urwaypayment.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wiyakm/apple_pay.dart';
import 'package:wiyakm/constants/strings.dart';
import 'package:wiyakm/main_categories.dart';
import 'package:wiyakm/navigator.dart';

class Web_View2 extends StatefulWidget {
  const Web_View2({Key? key, this.cookieManager, this.initialUrl})
      : super(key: key);

  final CookieManager? cookieManager;
  final String? initialUrl;

  @override
  State<Web_View2> createState() => _Web_View2State();
}

class _Web_View2State extends State<Web_View2> with WidgetsBindingObserver {
  double? _webViewHeight;

  // is true while a page loading is in progress
  bool _isPageLoading = true;
  bool Loading = true;
  String? lastUrl;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1), checkNewVersion);
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  checkNewVersion() async {
    try {
      final RemoteConfig remoteConfig = RemoteConfig.instance;
      await remoteConfig.fetchAndActivate();
      final requiredBuildNumber = remoteConfig.getInt(Platform.isAndroid
          ? 'requiredBuildNumberAndroid'
          : 'requiredBuildNumberIOS');
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final currentBuildNumber = int.parse(packageInfo.buildNumber);
      print("currentBuildNumber $currentBuildNumber");
      print("requiredBuildNumber $requiredBuildNumber");
      if (currentBuildNumber < requiredBuildNumber) {
        await _showUpdateDialog(
            remoteConfig.getBool('force'), remoteConfig.getString('message'));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _showUpdateDialog(bool force, String message) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) => WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
                    Image.asset(
                      "assets/logo.png",
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Text(
                      "${message ?? "update The App"}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 14),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 35,
                      width: 120,
                      child: FlatButton(
                        onPressed: () async {
                          String? updateURL = Strings.kUpgradeURLConfig[
                              Platform.isAndroid ? 'android' : 'ios'];
                          try {
                            await launch(updateURL ?? "");
                          } catch (e) {
                            print(e.toString());
                          }
                        },
                        child: Text(
                          "update",
                          style:
                              TextStyle(color: Color(0xFFEB7E23), fontSize: 14),
                        ),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Color(0xFFEB7E23),
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(3.0)),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    force
                        ? Container(
                            height: 35,
                            width: 120,
                            child: FlatButton(
                              onPressed: () async {
                                String? updateURL = Strings.kUpgradeURLConfig[
                                    Platform.isAndroid ? 'android' : 'ios'];
                                try {
                                  Navigator.pop(context);
                                } catch (e) {
                                  print(e.toString());
                                }
                              },
                              child: Text(
                                "Skip",
                                style: TextStyle(
                                    color: Color(0xFFEB7E23), fontSize: 14),
                              ),
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xFFEB7E23),
                                      width: 1,
                                      style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(3.0)),
                            ),
                          )
                        : Container(),
                  ],
                ),
              ),
            ))));
//    return showDialog(
//      context: context,
//      barrierDismissible: false, // user must tap button!
//      builder: (BuildContext context) {
//        return ;
//      },
//    );
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

  bool canback = false;
  int progress = 0;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: InkWell(
              onTap: () {
                controllerGlobal.loadUrl("${widget.initialUrl}");
              },
              child: Image.asset(
                "assets/logo.png",
                width: 100,
              )),
          centerTitle: true,
          leading: canback
              ? IconButton(
                  onPressed: () {
                    controllerGlobal.goBack();
                  },
                  icon: Icon(Icons.keyboard_arrow_right),
                )
              : Container(),
          actions: [
            IconButton(
              onPressed: () {
                controllerGlobal.reload();
                controllerGlobal.clearCache();
              },
              icon: Icon(Icons.refresh),
            )
          ],
        ),
        floatingActionButton: FabCircularMenu(

          children: <Widget>[
            IconButton(
                icon:Container(),
                onPressed: () async {

                }),
          // IconButton(
          //     icon: Icon(FontAwesomeIcons.twitter, color: Colors.white,size: 30,),
          //     onPressed: () async {
          //       await launch("https://twitter.com/wiakumsa");
          //     }) ,
          //   IconButton(
          //       icon: Icon(FontAwesomeIcons.facebook, color: Colors.white,size: 30,),
          //       onPressed: () async {
          //         await launch("https://www.facebook.com/wiakum.sa");
          //       }),
            IconButton(
              icon: Icon(Icons.call, color: Colors.white,size: 40,),
              onPressed: () async {
                await launch("tel://00966592385056");

              }),
            IconButton(
              icon: Icon(FontAwesomeIcons.whatsapp, color: Colors.white,size: 40,),
              onPressed: () async {
                await launch("https://wa.me/+966555575271");

              }),

        ],
          fabOpenIcon: Icon(Icons.chat, color: Colors.white),
          ringColor: Theme.of(context).primaryColor,
          ringWidth: 100.0,
          ringDiameter: 400.0,
          fabMargin: EdgeInsets.only(bottom: 70),fabSize: 50,fabOpenColor: Colors.white,
        alignment: Alignment.bottomLeft),
        body: WillPopScope(
          onWillPop: () => _exitApp(context),
          child: Stack(
            children: [
              Container(
                //  height:_webViewHeight,
                //height: MediaQuery.of(context).size.height,
                child: WebView(
                  initialUrl: widget.initialUrl,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    setState(() {
                      controllerGlobal = webViewController;
                    });
                    _controller.complete(webViewController);

                    /// controllerGlobal.clearCache();
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
                  onProgress: (int progress) async {
                    canback = await controllerGlobal.canGoBack();
                    setState(() {
                      this.progress = progress;
                      Loading = progress != 100;
                    });
                    print('WebView is loading (progress : $progress%)');
                  },
                  javascriptChannels: <JavascriptChannel>{
                    _toasterJavascriptChannel(context),
                  },
                  navigationDelegate: (NavigationRequest request) async {
                    // String url ="https://stage.wiakum.com/pub/applepay.php?order_id=55555&amount=1.00";
                    Uri uri;
                    uri = Uri.parse(request.url);
                    if (request.url.startsWith('https://www.youtube.com/')) {
                      print('blocking navigation to $request}');
                      return NavigationDecision.prevent;
                    } else if (request.url.startsWith(
                        'https://wiakum.com/payments/order/applepay/')) {
                      if (Platform.isAndroid) {
                        final snackBar =
                            SnackBar(content: Text('Apple Pay works with IOS'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        controllerGlobal.loadUrl(widget.initialUrl ?? '');
                      } else if (Platform.isIOS) {
                        var result = await Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Apple_Pay(
                            order_id: "${uri.queryParameters['orderId']}",
                            mount: '${uri.queryParameters['amount']}',
                          );
                        }));
                        if (result != null) {
                          controllerGlobal.loadUrl(result);
                        }
                      }

                      return NavigationDecision.prevent;
                    } else if (request.url
                            .startsWith('https://api.whatsapp.com/send') ||
                        request.url.startsWith(
                            'https://www.facebook.com/sharer/sharer') ||
                        request.url
                            .startsWith('https://twitter.com/intent/tweet?') ||
                        request.url
                            .startsWith('https://mail.google.com/mail')) {
                      NavigationDecision.navigate;
                      await controllerGlobal.goBack();
                      await FlutterShare.share(
                        title: 'وياكم  ',
                        text: ' منصه آمنه للتجارة الإلكترونية',
                        linkUrl: '$lastUrl',
                      );
                      controllerGlobal.loadUrl(lastUrl!);
                    } else {
                      lastUrl = request.url;
                    }
                    print('allowing navigation to $request');
                    return NavigationDecision.navigate;
                  },
                  gestureNavigationEnabled: true,
                  backgroundColor: const Color(0x00000000),
                ),
              ),
              Positioned(
                bottom: 1,
                right: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          controllerGlobal.loadUrl("${widget.initialUrl}");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: new BorderRadius.circular(20.0),
                            //  color: Colors.white,
                            //   boxShadow: const [
                            //      BoxShadow(
                            //         color: Colors.black12,
                            //         blurRadius: 5.0,
                            //         offset:  Offset(1.0, 1.0))
                            //   ],
                          ),
                          child: Image.asset(
                            "assets/logo_icon.png",
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                      InkWell(
                          onTap: () async {
                            var result = await Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return MainCategoriesPage();
                            }));
                            if (result != null) {
                              controllerGlobal.loadUrl(result);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: Image.asset(
                              "assets/computer-networks.png",
                              width: 30,
                              color: Colors.black87,
                            ),
                          )),
                      InkWell(
                          onTap: () async {

                          },
                          child: Container(
                            width: 50,
                          )),
                      InkWell(
                          onTap: () async {
                              controllerGlobal.loadUrl("https://wiakum.com/ar/customer/account/login/");
                          },
                          child: Container(width: 55,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              //borderRadius: new BorderRadius.circular(20.0),
                            ),
                            child: Icon(
                              FontAwesomeIcons.user,

                            ),
                          )),
                    ],
                  ),
                ),
              ),
              Loading
                  ? Container(
                      color: Colors.white,
                      child: Stack(
                        children: [
                          Center(
                              child: Text("$progress %",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.deepOrangeAccent,
                                      backgroundColor: Colors.white))),
                          Center(child: Image.asset("assets/splash.gif")),
                        ],
                      ))
                  : Container(),
            ],
          ),
        ),
      ),
    );
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
                          child:
                              Text("No", style: TextStyle(color: Colors.black)),
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

  Future<void> _performtrxn(BuildContext context, amount, orderid) async {
    var lastResult = "";
    var act = '1';

    print("In apple pay");
    lastResult = await Payment.makeapplepaypaymentService(
        context: context,
        country: "SA",
        action: act,
        currency: "SAR",
        amt: amount,
        customerEmail: "omarhussien61@gmail.com",
        trackid: orderid,
        udf1: "",
        udf2: "",
        udf3: "",
        udf4: "",
        udf5: "",
        tokenizationType: "1",
        merchantIdentifier: "merchant.com.alajlanonline.com.app",
        shippingCharge: "0.00",
        companyName: "alajlan online");
    controllerGlobal.loadUrl(
        "https://wiakum.com/payments/order/applepay?orderId=${orderid}&amount=${amount}&payment_result=success&merchant_reference=1999&payment_id=4343434");

    print('Payment $lastResult');
  }
}
