import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezeehome_webview/Contrlller/InternetConnectivity.dart';
import 'package:ezeehome_webview/Screens/bottom_navigation_bar.dart';
import 'package:ezeehome_webview/Static/staticdata.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // Request notification permission
  await requestNotificationPermission();

  // firebase intialization
  await Firebase.initializeApp();

  await checkInternetConnectionForDashboard();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    // systemNavigationBarColor: MyColors.kprimaryshade,
    statusBarColor: Colors.white,
  ));
  await fetchData();
  // requestCameraPermission();

  runApp(MyApp());
}
requestNotificationPermission() async {
  PermissionStatus status = await Permission.notification.request();

  if (status.isGranted) {
    // Permission granted, you can now access notifications
    print('Notification permission granted');
  } else {
    // Permission denied
    print('Notification permission denied');
  }
}


// void requestCameraPermission() async {
//   PermissionStatus status = await Permission.camera.request();

//   if (status.isGranted) {
//     // Permission granted, you can now access the camera
//     print('here granted');
//   } else {
//     // Permission denied
//     print('here denied');
//   }
// }

Future<void> firebaseOnBackgroundMessage(RemoteMessage message) async {
  try {
    print("Firebase onBgMsg ${message.notification?.title}");
    print("Firebase onBgMsg ${message.notification?.body}");
  } catch (e) {
    print("Firebase onBgMsg ${e.toString()}");
  }
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

// static String? _button1link;

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
    ButtonData button5Data = await getButtonData('Button5');

    ButtonData BookNowButton1 = await getButtonData('BookNowButton1');
    ButtonData BookNowButton2 = await getButtonData('BookNowButton2');
    ButtonData BookNowButton3 = await getButtonData('BookNowButton3');
    ButtonData BookNowButton4 = await getButtonData('BookNowButton4');
    ButtonData BookNowButton5 = await getButtonData('BookNowButton5');
    ButtonData BookNowButton6 = await getButtonData('BookNowButton6');

    MyStaticVariable.button1label = button1Data.label;
    MyStaticVariable.button1link = button1Data.link;

    MyStaticVariable.button2label = button2Data.label;
    MyStaticVariable.button2link = button2Data.link;

    MyStaticVariable.button3label = button3Data.label;
    MyStaticVariable.button3link = button3Data.link;

    MyStaticVariable.button4label = button4Data.label;
    MyStaticVariable.button4link = button4Data.link;

    MyStaticVariable.button5label = button5Data.label;
    MyStaticVariable.button5link = button5Data.link;

    MyStaticVariable.BookNowButton1label = BookNowButton1.label;
    MyStaticVariable.BookNowButton1link = BookNowButton1.link;

    MyStaticVariable.BookNowButton2label = BookNowButton2.label;
    MyStaticVariable.BookNowButton2link = BookNowButton2.link;

    MyStaticVariable.BookNowButton3label = BookNowButton3.label;
    MyStaticVariable.BookNowButton3link = BookNowButton3.link;

    MyStaticVariable.BookNowButton4label = BookNowButton4.label;
    MyStaticVariable.BookNowButton4link = BookNowButton4.link;

    MyStaticVariable.BookNowButton5label = BookNowButton5.label;
    MyStaticVariable.BookNowButton5link = BookNowButton5.link;

    MyStaticVariable.BookNowButton6label = BookNowButton6.label;
    MyStaticVariable.BookNowButton6link = BookNowButton6.link;
  } catch (e) {
    // Handle any errors that occur during the process
    print('Error: $e');
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// //use this to get start of the screen
// navigatorKey.currentState.push(
//   MaterialPageRoute(
//     builder: (context) => NextScreen(),
//   ),
// );
class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    firebaseMessaging.getToken().then((value) {
      print("FirebaseMessagingtoken ::${value}");
    });
    initializeFirebaseMessaging();
    FirebaseMessaging.onBackgroundMessage(firebaseOnBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received: ${message.notification?.title}');
      // Handle the foreground message here
      // You can show a dialog, update the app UI, or perform any required action
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked!');
      // Handle the notification click event here
      // You can navigate to a specific screen or perform any required action
    });

    super.initState();
  }

  Future<void> initializeFirebaseMessaging() async {
    // Request permission to receive notifications
    await firebaseMessaging.requestPermission();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Mascot Travel',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FirstScreen(
          isInternetConnected: isInternetConnected,
        ));
  }
}
