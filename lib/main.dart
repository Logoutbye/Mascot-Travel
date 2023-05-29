import 'package:cloud_firestore/cloud_firestore.dart';
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
  await fetchData();
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

String? _button1link;
String? _button1label;
String? _button2link;
String? _button2label;
String? _button3link;
String? _button3label;
String? _button4link;
String? _button4label;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<ButtonData> getButtonData(String documentId) async {
  try {
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('App Urls').doc(documentId).get();

    var data = documentSnapshot.data() as Map<String, dynamic>;

    // Create a new instance of ButtonData using the data from the document
    ButtonData buttonData = ButtonData(
      link: data['url'] as String,
      label: data['label'] as String,
    );

    return buttonData;
  } catch (e) {
    // Handle any errors that occur during the process
    print('Error: $e');
    return ButtonData(link: '', label: '');
  }
}

Future<void> fetchData() async {
  try {
    ButtonData button1Data = await getButtonData('Button1');
    ButtonData button2Data = await getButtonData('Button2');
    ButtonData button3Data = await getButtonData('Button3');
    ButtonData button4Data = await getButtonData('Button4');

    _button1label = button1Data.label;
    _button1link = button1Data.link;

    _button2label = button2Data.label;
    _button2link = button2Data.link;

    _button3label = button3Data.label;
    _button3link = button3Data.link;

    _button4label = button4Data.label;
    _button4link = button4Data.link;

    // Do something with the retrieved data
    print('New Button 1 Label: ${_button1link}');
    print('Button 1 Label: ${button1Data.label}');
    print('Button 1 Link: ${button1Data.link}');

    print('Button 2 Label: ${button2Data.label}');
    print('Button 2 Link: ${button2Data.link}');

    print('Button 2 Label: ${button3Data.label}');
    print('Button 2 Link: ${button3Data.link}');

    print('Button 2 Label: ${button4Data.label}');
    print('Button 2 Link: ${button4Data.link}');
  } catch (e) {
    // Handle any errors that occur during the process
    print('Error: $e');
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
        home: FirstScreen(
          isInternetConnected: isInternetConnected,
          button1label: _button1label,
          button1link: _button1link,
          button2label: _button2label,
          button2link: _button2link,
          button3label: _button3label,
          button3link: _button3link,
          button4label: _button4label,
          button4link: _button4link,
        )

        //  Home(
        //   isInternetConnected: isInternetConnected,
        // )
        );
  }
}
