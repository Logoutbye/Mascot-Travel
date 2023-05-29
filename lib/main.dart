import 'package:ezeehome_webview/Contrlller/InternetConnectivity.dart';
import 'package:ezeehome_webview/Screens/bottom_navigation_bar.dart';
import 'package:ezeehome_webview/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // firebase intialization
  await Firebase.initializeApp();

  await checkInternetConnectionForDashboard();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: MyColors.kprimaryshade,
    statusBarColor: MyColors.kprimaryshade,
  ));

  runApp(MyApp());
}

var isInternetConnected = false;
checkInternetConnectionForDashboard() async {
  // to check the internet connection
  await CheckInternetConnection.checkInternetFunction();

  if (!CheckInternetConnection.checkInternet) {
    isInternetConnected = false;
  } else {
    isInternetConnected = true;
  }
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Mascot Travel',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: FirstScreen(isInternetConnected: isInternetConnected)

        //  Home(
        //   isInternetConnected: isInternetConnected,
        // )
        );
  }
}
