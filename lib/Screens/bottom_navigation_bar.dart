import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezeehome_webview/Screens/Home.dart';
import 'package:ezeehome_webview/constants.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class FirstScreen extends StatefulWidget {
  bool isInternetConnected;

  String? button1link;
  String? button1label;
  String? button2link;
  String? button2label;
  String? button3link;
  String? button3label;
  String? button4link;
  String? button4label;

  FirstScreen({
    super.key,
    required this.isInternetConnected,
    required this.button1label,
    required this.button1link,
    required this.button2label,
    required this.button2link,
    required this.button3label,
    required this.button3link,
    required this.button4label,
    required this.button4link,
  });

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String? _button1link;
  String? _button1label;
  String? _button2link;
  String? _button2label;
  String? _button3link;
  String? _button3label;
  String? _button4link;
  String? _button4label;

  var IsInternetConnected = true;
  @override
  void initState() {
    _button1label = widget.button1label;
    _button1link = widget.button1link;

    _button2label = widget.button2label;
    _button2link = widget.button2link;

    _button3label = widget.button3label;
    _button3link = widget.button3link;

    _button4label = widget.button4label;
    _button4link = widget.button4link;

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
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
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
                  label: '$_button1label'),
              NavigationDestination(
                  icon: Icon(
                    Icons.chat_bubble_outline,
                    color: MyColors.kprimaryColor,
                  ),
                  selectedIcon: Icon(
                    Icons.chat_bubble_outlined,
                    color: MyColors.kprimaryshade,
                  ),
                  label: '$_button2label'),
              NavigationDestination(
                  icon: Icon(
                    Icons.info_outline,
                    color: MyColors.kprimaryColor,
                  ),
                  selectedIcon: Icon(
                    Icons.info,
                    color: MyColors.kprimaryshade,
                  ),
                  label: "$_button3label"),
              NavigationDestination(
                  icon: Icon(
                    Icons.contact_mail_outlined,
                    color: MyColors.kprimaryColor,
                  ),
                  selectedIcon: Icon(
                    Icons.contact_mail_rounded,
                    color: MyColors.kprimaryshade,
                  ),
                  label: "$_button4label"),
            ]),
      ),
    );
  }

  // Future<ButtonData> getButtonData(String documentId) async {
  //   try {
  //     DocumentSnapshot documentSnapshot =
  //         await _firestore.collection('App Urls').doc(documentId).get();

  //     var data = documentSnapshot.data() as Map<String, dynamic>;

  //     // Create a new instance of ButtonData using the data from the document
  //     ButtonData buttonData = ButtonData(
  //       link: data['url'] as String,
  //       label: data['label'] as String,
  //     );

  //     return buttonData;
  //   } catch (e) {
  //     // Handle any errors that occur during the process
  //     print('Error: $e');
  //     return ButtonData(link: '', label: '');
  //   }
  // }

  // Future<void> fetchData() async {
  //   try {
  //     ButtonData button1Data = await getButtonData('Button1');
  //     ButtonData button2Data = await getButtonData('Button2');
  //     ButtonData button3Data = await getButtonData('Button3');
  //     ButtonData button4Data = await getButtonData('Button4');

  //     _button1label = button1Data.label;
  //     _button1link = button1Data.link;

  //     _button2label = button2Data.label;
  //     _button2link = button2Data.link;

  //     _button3label = button3Data.label;
  //     _button3link = button3Data.link;

  //     _button4label = button4Data.label;
  //     _button4link = button4Data.link;

  //     // Do something with the retrieved data
  //     print('New Button 1 Label: ${_button1label}');
  //     print('Button 1 Label: ${button1Data.label}');
  //     print('Button 1 Link: ${button1Data.link}');

  //     print('Button 2 Label: ${button2Data.label}');
  //     print('Button 2 Link: ${button2Data.link}');

  //     print('Button 2 Label: ${button3Data.label}');
  //     print('Button 2 Link: ${button3Data.link}');

  //     print('Button 2 Label: ${button4Data.label}');
  //     print('Button 2 Link: ${button4Data.link}');
  //   } catch (e) {
  //     // Handle any errors that occur during the process
  //     print('Error: $e');
  //   }
  // }

}

class ButtonData {
  String link;
  String label;

  ButtonData({required this.link, required this.label});
}
