
import 'package:ezeehome_webview/Screens/screen1.dart';
import 'package:ezeehome_webview/Screens/Screen4.dart';
import 'package:ezeehome_webview/Screens/screen2.dart';
import 'package:ezeehome_webview/Screens/screen3.dart';
import 'package:ezeehome_webview/Screens/screen5.dart';
import 'package:ezeehome_webview/Static/staticdata.dart';
import 'package:ezeehome_webview/constants.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class FirstScreen extends StatefulWidget {
  bool isInternetConnected;

  // String? button1link;
  // String? button1label;
  // String? button2link;
  // String? button2label;
  // String? button3link;
  // String? button3label;
  // String? button4link;
  // String? button4label;
  // String? button5link;
  // String? button5label;
  // String? giveBookNowButton1link;
  // String? giveBookNowButton1label;
  // String? giveBookNowButton2link;
  // String? giveBookNowButton2label;
  // String? giveBookNowButton3link;
  // String? giveBookNowButton3label;
  // String? giveBookNowButton4link;
  // String? giveBookNowButton4label;
  // String? giveBookNowButton5link;
  // String? giveBookNowButton5label;
  // String? giveBookNowButton6link;
  // String? giveBookNowButton6label;

  FirstScreen({
    super.key,
    required this.isInternetConnected,
    // required this.button1label,
    // required this.button1link,
    // required this.button2label,
    // required this.button2link,
    // required this.button3label,
    // required this.button3link,
    // required this.button4label,
    // required this.button4link,
    // required this.button5label,
    // required this.button5link,
    // required this.giveBookNowButton1link,
    // required this.giveBookNowButton1label,
    // required this.giveBookNowButton2link,
    // required this.giveBookNowButton2label,
    // required this.giveBookNowButton3link,
    // required this.giveBookNowButton3label,
    // required this.giveBookNowButton4link,
    // required this.giveBookNowButton4label,
    // required this.giveBookNowButton5link,
    // required this.giveBookNowButton5label,
    // required this.giveBookNowButton6link,
    // required this.giveBookNowButton6label
  });

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // String? _button1link;
  // String? _button1label;
  // String? _button2link;
  // String? _button2label;
  // String? _button3link;
  // String? _button3label;
  // String? _button4link;
  // String? _button4label;
  // String? _button5link;
  // String? _button5label;
  // String? _booknowbutton1link;
  // String? _booknowbutton1label;
  // String? _booknowbutton2link;
  // String? _booknowbutton2label;
  // String? _booknowbutton3link;
  // String? _booknowbutton3label;
  // String? _booknowbutton4link;
  // String? _booknowbutton4label;
  // String? _booknowbutton5link;
  // String? _booknowbutton5label;
  // String? _booknowbutton6link;
  // String? _booknowbutton6label;

  var IsInternetConnected = true;

  // var _selectedLink;

  @override
  void initState() {
    alpha();

    // TODO: implement initState
    super.initState();
  }

  var index = 0;
  var screen;
  void alpha() {
    screen = [
      Screen1(
        isInternetConnected: isInternetConnected,
        link: '${MyStaticVariable.button1link}',
      ),
      Screen2(
        isInternetConnected: isInternetConnected,
        link: '${MyStaticVariable.button2link}',
      ),
      Screen3(
        isInternetConnected: isInternetConnected,
        link: '${MyStaticVariable.button3link}',
      ),
      Screen4(
        isInternetConnected: isInternetConnected,
      ),
      Screen5(
          isInternetConnected: isInternetConnected,
          link: '${MyStaticVariable.button5link}')
    ];
    print("objectobjectobject$index");
  }

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          elevation: 0,
        ),
      ),
      body: screen[index],
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            height: MediaQuery.of(context).size.height / 15,
            indicatorColor: Colors.transparent),
        child: NavigationBar(
            backgroundColor: MyColors.kprimaryshade,
            selectedIndex: MyStaticVariable.previousScreenIndex > 4 ? 3 : index,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            animationDuration: Duration(seconds: 2),
            onDestinationSelected: (index) => setState(() {
                  MyStaticVariable.setData(index, this.index);
                  this.index = index;

                  if (index == 3) {
                    _openModalSheet(context);
                  }

                  if (index == 0) {
                    setState(() {
                      navigatorKey.currentState!
                          .popUntil((route) => route.isFirst);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => FirstScreen(
                              isInternetConnected: isInternetConnected)));
                    });
                  }
                  print(
                      'Print my index ${MyStaticVariable.previousScreenIndex}');
                }),
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: MyColors.ksecondary,
                ),
                selectedIcon: Icon(
                  Icons.home_outlined,
                  color: MyColors.kprimaryColor,
                ),
                label: '${MyStaticVariable.button1label}',
              ),
              NavigationDestination(
                  icon: Icon(
                    Icons.search,
                    color: MyColors.ksecondary,
                  ),
                  selectedIcon: Icon(
                    Icons.search,
                    color: MyColors.kprimaryColor,
                  ),
                  label: '${MyStaticVariable.button2label}'),
              NavigationDestination(
                  icon: Icon(
                    Icons.chrome_reader_mode_rounded,
                    color: MyColors.ksecondary,
                  ),
                  selectedIcon: Icon(
                    Icons.chrome_reader_mode_rounded,
                    color: MyColors.kprimaryColor,
                  ),
                  label: "${MyStaticVariable.button3label}"),
              NavigationDestination(
                icon: Icon(
                  Icons.edit_calendar_outlined,
                  color: MyColors.ksecondary,
                ),
                selectedIcon: Icon(
                  Icons.edit_calendar_outlined,
                  color: MyColors.kprimaryColor,
                ),
                label: '${MyStaticVariable.button4label}',
              ),
              NavigationDestination(
                  icon: Icon(
                    Icons.reviews,
                    color: MyColors.ksecondary,
                  ),
                  selectedIcon: Icon(
                    Icons.reviews,
                    color: MyColors.kprimaryColor,
                  ),
                  label: "${MyStaticVariable.button5label}"),
            ]),
      ),
    );
  }

  void _openModalSheet(BuildContext context) {
    showModalBottomSheet(
      showDragHandle: true,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white.withOpacity(0.9),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.flight),
                title: Text('${MyStaticVariable.BookNowButton1label}'),
                onTap: () {
                  setState(() {
                    MyStaticVariable.setData(5, 5);
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FirstScreen(
                            isInternetConnected: isInternetConnected)));
                  });
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.hotel),
                title: Text('${MyStaticVariable.BookNowButton2label}'),
                onTap: () {
                  setState(() {
                    MyStaticVariable.setData(5, 6);
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FirstScreen(
                            isInternetConnected: isInternetConnected)));
                  });
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.tour),
                title: Text('${MyStaticVariable.BookNowButton3label}'),
                onTap: () {
                  setState(() {
                    MyStaticVariable.setData(5, 7);
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FirstScreen(
                            isInternetConnected: isInternetConnected)));
                  });
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.volunteer_activism_outlined),
                title: Text('${MyStaticVariable.BookNowButton4label}'),
                onTap: () {
                  setState(() {
                    MyStaticVariable.setData(5, 8);
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FirstScreen(
                            isInternetConnected: isInternetConnected)));
                  });
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.car_rental_sharp),
                title: Text('${MyStaticVariable.BookNowButton5label}'),
                onTap: () {
                  setState(() {
                    MyStaticVariable.setData(5, 9);
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FirstScreen(
                            isInternetConnected: isInternetConnected)));
                  });
                },
              ),
              Divider(),
              ListTile(
                leading: Image.asset(
                  'assets/images/ferry-boat.png',
                  height: MediaQuery.of(context).size.height / 30,
                ),
                title: Text('${MyStaticVariable.BookNowButton6label}'),
                onTap: () {
                  setState(() {
                    MyStaticVariable.setData(5, 10);
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => FirstScreen(
                            isInternetConnected: isInternetConnected)));
                  });
                },
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}

class ButtonData {
  String link;
  String label;

  ButtonData({required this.link, required this.label});
}
