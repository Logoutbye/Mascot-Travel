import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezeehome_webview/Contrlller/InternetConnectivity.dart';
import 'package:ezeehome_webview/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:lottie/lottie.dart';

import '../Static/staticdata.dart';

class Screen1 extends StatefulWidget {
  Screen1({
    super.key,
    required this.isInternetConnected,
    required this.link,
  }) {}

  bool isInternetConnected;
  String? link;
  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  var IsInternetConnected = true;
  bool loader = false;
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  final _webViewController = Completer<WebViewController>();
  double _progress = 0.0; // Variable to hold the progress percentage
  bool _isLoading = true;
  int _progressText = 0;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool shouldShowPopUp = false;
  late WebViewController webViewController; // Variable to track loading state
  var staticLink; // Variable to track loading state

  @override
  void initState() {

        fetchPopUpSettings();

 staticLink = MyStaticVariable.currentScreenIndex == 0
        ? '${MyStaticVariable.button1link}'
        : MyStaticVariable.currentScreenIndex == 1
            ? '${MyStaticVariable.button2link}'
            : MyStaticVariable.previousScreenIndex == 2
                ? '${MyStaticVariable.button3link}'
                : MyStaticVariable.previousScreenIndex == 4
                    ? '${MyStaticVariable.button5link}'
                    : MyStaticVariable.previousScreenIndex == 5
                        ? '${MyStaticVariable.BookNowButton1link}'
                        : MyStaticVariable.previousScreenIndex == 6
                            ? '${MyStaticVariable.BookNowButton2link}'
                            : MyStaticVariable.previousScreenIndex == 7
                                ? '${MyStaticVariable.BookNowButton3link}'
                                : MyStaticVariable.previousScreenIndex == 8
                                    ? '${MyStaticVariable.BookNowButton4link}'
                                    : MyStaticVariable.previousScreenIndex == 9
                                        ? '${MyStaticVariable.BookNowButton5link}'
                                        : MyStaticVariable.previousScreenIndex ==10
                                            ? '${MyStaticVariable.BookNowButton6link}'
                                            : '';



    print('index at screen 1::${MyStaticVariable.previousScreenIndex}');
    checkInternetConnectionForDashboard();
    // checkInternetConnection();
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
        appBar:
            // PreferredSize(
            //   preferredSize: Size.fromHeight(31),
            //   child: AppBar(
            //     backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            //     foregroundColor: Colors.black,
            //     elevation: 0,
            //     actions: [
            //       Padding(
            //         padding: const EdgeInsets
            //             // .fromLTRB(8, 0, 8, 18),
            //             .symmetric(horizontal: 8.0),
            //         child: IconButton(
            //             onPressed: () {
            //               webViewController.reload();
            //             },
            //             icon: Icon(Icons.refresh)),
            //       )
            //     ],
            //   ),
            // ),

            PreferredSize(
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
                                // Text(
                                //   'swipe down to refresh',
                                //   style: TextStyle(
                                //     fontSize: 18,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: MyColors.kprimaryColor,
                            ),
                            onPressed: () {
                              refresh();
                            },
                            child: Text('Reload Page'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Stack(
                children: [
                  WebView(
                    initialUrl: staticLink,
                    javascriptMode: JavascriptMode.unrestricted,
                    onWebViewCreated: (WebViewController webViewController) {
                      _webViewController.complete(webViewController);
                      this.webViewController = webViewController;
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
                      child: Lottie.asset('assets/animations/loading.json',
                          height: MediaQuery.of(context).size.height / 1),

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

    void fetchPopUpSettings() async {
    final docSnapshot =
        await firestore.collection('pop_up_settings').doc('admin').get();
    final popUpSettings = docSnapshot.data();

    final isDailyEnabled = popUpSettings?['daily'] ?? false;
    final isWeeklyEnabled = popUpSettings?['weekly'] ?? false;
    final isMonthlyEnabled = popUpSettings?['monthly'] ?? false;

    final currentDate = DateTime.now();
    final lastPopUpDate = popUpSettings?['lastPopUpDate'] as Timestamp?;
    final difference =
        currentDate.difference(lastPopUpDate?.toDate() ?? currentDate);

    setState(() {
      shouldShowPopUp = (isDailyEnabled && difference.inDays >= 1) ||
          (isWeeklyEnabled && difference.inDays >= 7) ||
          (isMonthlyEnabled && difference.inDays >= 30);
    });

    if (shouldShowPopUp) {
      showPopUp();
      saveLastPopUpDate();
    }
  }

  void saveLastPopUpDate() async {
    final currentDate = DateTime.now();
    final docRef = firestore.collection('pop_up_settings').doc('admin');
    await docRef.update({'lastPopUpDate': currentDate});
  }

  void showPopUp() {
    FirebaseFirestore.instance
        .collection('popups')
        .doc(
            'popup1') // Assuming you have a document with ID 'popup1' containing the pop-up content
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        String title = documentSnapshot['title'];
        String image = documentSnapshot['image'];
        String subheading = documentSnapshot['subheading'];
        String description = documentSnapshot['description'];

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(title),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  image.isNotEmpty
                      ? Image.network(
                          image,
                          height: 150,
                        )
                      : SizedBox(),
                  SizedBox(height: 16),
                  subheading.isNotEmpty
                      ? Text(
                          subheading,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 8),
                  description.isNotEmpty
                      ? SizedBox(
                        height: MediaQuery.of(context).size.height/10,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          child: Text(
                              description,
                              style: TextStyle(color: Color.fromARGB(255, 91, 91, 91),fontSize: 15),
                              textAlign: TextAlign.start,
                            ),
                        ),
                      )
                      : SizedBox(),
                ],
              ),
              actions: [
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }

}
