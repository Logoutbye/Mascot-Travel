import 'package:ezeehome_webview/Screens/screen1.dart';
import 'package:ezeehome_webview/Screens/Screen4.dart';
import 'package:ezeehome_webview/Screens/screen2.dart';
import 'package:ezeehome_webview/Screens/screen3.dart';
import 'package:ezeehome_webview/Screens/screen5.dart';
import 'package:ezeehome_webview/Static/staticdata.dart';
import 'package:ezeehome_webview/constants.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Contrlller/slide_transition_page.dart';
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
                  if (index != 3) {
                    this.index = index;
                  }

                  if (index == 3) {
                    _openModalSheet(context);
                    print('here');

                   
                  }

                  if (index == 0) {
                    setState(() {
                      navigatorKey.currentState!
                          .popUntil((route) => route.isFirst);

                      Navigator.pushReplacement(
                        context,
                        SlideTransitionPage(
                            applySlideTransition: false,
                            page: FirstScreen(
                              isInternetConnected: isInternetConnected,
                            )),
                      );
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(
                      //     builder: (context) => FirstScreen(
                      //         isInternetConnected: isInternetConnected)));
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
