import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezeehome_webview/Screens/Home.dart';
import 'package:ezeehome_webview/constants.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class FirstScreen extends StatefulWidget {
  bool isInternetConnected;

  FirstScreen({
    super.key,
    required this.isInternetConnected,
  });

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  var IsInternetConnected = true;
  @override
  void initState() {
    fetchData();
    // TODO: implement initState
    super.initState();
  }

  var index = 0;
  final screen = [
    Home(isInternetConnected: isInternetConnected),
    Home(isInternetConnected: isInternetConnected),
    Home(isInternetConnected: isInternetConnected),
    Home(isInternetConnected: isInternetConnected)
  ];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: MyColors.kprimaryColor,
        ),
        child: NavigationBar(
            backgroundColor: MyColors.kprimaryshade,
            selectedIndex: index,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            animationDuration: Duration(seconds: 2),
            onDestinationSelected: (index) => setState(() {
                  this.index = index;
                }),
            destinations: [
              NavigationDestination(
                  icon: Icon(
                    Icons.home_outlined,
                    color: MyColors.kprimaryColor,
                  ),
                  selectedIcon: Icon(
                    Icons.home_filled,
                    color: MyColors.kprimaryshade,
                  ),
                  label: "Home"),
              NavigationDestination(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: MyColors.kprimaryColor,
                  ),
                  selectedIcon: Icon(
                    Icons.chat_bubble_outlined,
                    color: MyColors.kprimaryshade,
                  ),
                  label: "Blog"),
              NavigationDestination(
                  icon: Icon(
                    Icons.info_outline,
                    color: MyColors.kprimaryColor,
                  ),
                  selectedIcon: Icon(
                    Icons.info,
                    color: MyColors.kprimaryshade,
                  ),
                  label: "About Us"),
              NavigationDestination(
                  icon: Icon(
                    Icons.contact_mail_outlined,
                    color: MyColors.kprimaryColor,
                  ),
                  selectedIcon: Icon(
                    Icons.contact_mail_rounded,
                    color: MyColors.kprimaryshade,
                  ),
                  label: "Contact Us"),
            ]),
      ),
    );
  }

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

      // Do something with the retrieved data
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
}

class ButtonData {
  final String link;
  final String label;

  ButtonData({required this.link, required this.label});
}
