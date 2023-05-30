import 'dart:async';
import 'dart:io';

import 'package:ezeehome_webview/Contrlller/InternetConnectivity.dart';
import 'package:ezeehome_webview/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class Screen4 extends StatefulWidget {
  Screen4({
    super.key,
    required this.isInternetConnected,
    required this.link,
  }) {}

  bool isInternetConnected;
  String? link;
  @override
  State<Screen4> createState() => _Screen4State();
}

class _Screen4State extends State<Screen4> {
  var IsInternetConnected = true;
  bool loader = false;
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  final _webViewController = Completer<WebViewController>();
  double _progress = 0.0; // Variable to hold the progress percentage
  bool _isLoading = true;

  int _progressText = 0; // Variable to track loading state

  @override
  void initState() {
    print('object${widget.link}');
    checkInternetConnectionForDashboard();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
    // requestPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool? goBack =
            await _webViewController.future.then((value) => value.canGoBack());
        if (goBack != true) {
          return true;
        } else {
          _webViewController.future.then((controller) => controller.goBack());
          return false;
        }
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: MyColors.kprimaryColor,
            elevation: 0,
          ),
        ),
        body: IsInternetConnected == false
            ? RefreshIndicator(
                onRefresh: () {
                  return Future.delayed(Duration(seconds: 1), () {
                    refresh();
                  });
                },
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.signal_wifi_connected_no_internet_4,
                            size: 60,
                            color: MyColors.kprimaryColor,
                          ),
                          Container(
                            child: Column(
                              children: [
                                Text(
                                  'No Internet Connection',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  'swipe down to refresh',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // ElevatedButton(
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: MyColors.kprimaryColor,
                          //   ),
                          //   onPressed: () {
                          //     refresh();
                          //   },
                          //   child: Text('Reload Page'),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  WebView(
                    initialUrl: widget.link,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _webViewController.complete(webViewController);
                    },
                    javascriptChannels: <JavascriptChannel>{
                      // _toasterJavascriptChannel(context),
                      JavascriptChannel(
                          name: 'Toaster',
                          onMessageReceived: (JavascriptMessage message) {
                            var snackBar = SnackBar(
                              content: Text(message.message),
                            );
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          })
                    },
                    // navigationDelegate: (NavigationRequest request) {
                    //   if (request.url.startsWith('${widget.link}')) {
                    //     return NavigationDecision.navigate;
                    //   } else if (request.url
                    //       .startsWith('https://www.youtube.com/')) {
                    //     print('blocking navigation to $request}');
                    //     return NavigationDecision.prevent;
                    //   } else {
                    //     print('opening external link');
                    //     _launchExternalUrl(request.url);
                    //     // launchUrl(Uri.parse(request.url));
                    //   }
                    //   print('allowing navigation to $request');
                    //   return NavigationDecision.navigate;
                    // },
                    onProgress: (int progress) {
                      print("WebView is loading (progress : $progress%)");
                      setState(() {
                        _progress = progress / 100;
                        _progressText = progress;
                        // Update progress based on the value received (0-100)
                      });
                    },
                    onPageStarted: (String url) {
                      print('Page started loading: $url');
                      setState(() {
                        _isLoading =
                            true; // Set loading state to true when a new page starts loading
                      });
                    },
                    onPageFinished: (String url) {
                      print('Page finished loading: $url');
                      setState(() {
                        _isLoading =
                            false; // Set loading state to false when the page finishes loading
                      });
                    },
                    gestureNavigationEnabled: true,
                    geolocationEnabled: false,
                    zoomEnabled: true,
                  ),
                  Visibility(
                    visible:
                        _isLoading, // Show the progress indicator only when loading
                    child: Center(
                      child: Lottie.asset('assets/animations/loading.json',height: MediaQuery.of(context).size.height/6),

                      //  CircularPercentIndicator(
                      //   radius: 80.0,
                      //   lineWidth: 15.0,
                      //   percent: _progress,
                      //   center: new Text(
                      //     "$_progressText%",
                      //     style: TextStyle(
                      //         color: MyColors.kprimaryColor, fontSize: 40),
                      //   ),
                      //   progressColor: MyColors.kprimaryColor,
                      //   backgroundColor: MyColors.kprimaryshade,
                      //   circularStrokeCap: CircularStrokeCap.round,
                      // ),
                    ),
                    //  CircularProgressIndicator(value: _progress),
                  ),
                ],
              ),
      ),
    );
  }

  // Future<void> _launchExternalUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(url, forceSafariVC: false, forceWebView: false);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void refresh() {
    setState(() {
      IsInternetConnected = true;
    });
    checkInternetConnectionForDashboard();
  }

  checkInternetConnectionForDashboard() async {
    // to check the internet connection
    await CheckInternetConnection.checkInternetFunction();

    if (!CheckInternetConnection.checkInternet) {
      setState(() {
        IsInternetConnected = false;
        loader = true;
        print('//////////// Failed to Refresh');
      });
    } else {
      setState(() {
        loader = true;
        IsInternetConnected = true;
        print('Successful');
      });
    }
  }
}
