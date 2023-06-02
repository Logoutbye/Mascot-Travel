import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ezeehome_webview/Screens/build_sheet_for_book_now.dart';
import 'package:ezeehome_webview/Screens/reloadableScreeen.dart';
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

  var _selectedLink;
  late Screen3Reloadable screen3Reloadable;

  var _index;
  @override
  void initState() {
    // _button1label = widget.button1label;
    // // _button1link = widget.button1link;
    // _button2label = widget.button2label;
    // _button2link = widget.button2link;
    // _button3label = widget.button3label;
    // _button3link = widget.button3link;
    // _button4label = widget.button4label;
    // _button4link = widget.button4link;
    // _button5label = widget.button5label;
    // _button5link = widget.button5link;
    // _booknowbutton1label = widget.giveBookNowButton1label;
    // _booknowbutton1link = widget.giveBookNowButton1link;
    // _booknowbutton2label = widget.giveBookNowButton2label;
    // _booknowbutton2link = widget.giveBookNowButton2link;
    // _booknowbutton3label = widget.giveBookNowButton3label;
    // _booknowbutton3link = widget.giveBookNowButton3link;
    // _booknowbutton4label = widget.giveBookNowButton4label;
    // _booknowbutton4link = widget.giveBookNowButton4link;
    // _booknowbutton5label = widget.giveBookNowButton5label;
    // _booknowbutton5link = widget.giveBookNowButton5link;
    // _booknowbutton6label = widget.giveBookNowButton6label;
    // _booknowbutton6link = widget.giveBookNowButton6link;
    print('check${_selectedLink}');
    // fetchData();
    alpha();
    screen3Reloadable = Screen3Reloadable(
      isInternetConnected: isInternetConnected,
      // initialLink: _selectedLink,
    );
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
        link: 'null',
      ),
      Screen5(
          isInternetConnected: isInternetConnected,
          link: '${MyStaticVariable.button5link}')
    ];
    print("objectobjectobject$_index");
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
            selectedIndex: index,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            animationDuration: Duration(seconds: 2),
            onDestinationSelected: (index) => setState(() {
                  MyStaticVariable.setData(index, this.index);
                  this.index = index;

                  if (index == 3) {
                    _openModalSheet(context);
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
                      //Screen3Reloadable screen3Reloadable;
                      screen3Reloadable.updateLink('newLink');
                    MyStaticVariable.setData(4, 5);
                    Navigator.pop(context);
                    khan(context);

                  });
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.hotel),
                title: Text('${MyStaticVariable.BookNowButton2label}'),
                onTap: () {
                  setState(() {
                    _selectedLink = MyStaticVariable.BookNowButton2link;
                    // isInternetConnected =true;
                    // alpha();
                  });
                  // Navigator.pop(context);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Screen4(
                  //         isInternetConnected: isInternetConnected,
                  //         link: _selectedLink)));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.tour),
                title: Text('${MyStaticVariable.BookNowButton3label}'),
                onTap: () {
                  setState(() {
                    _selectedLink = MyStaticVariable.BookNowButton3link;
                    // isInternetConnected =true;
                    // alpha();
                  });
                  // Navigator.pop(context);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Screen4(
                  //         isInternetConnected: isInternetConnected,
                  //         link: _selectedLink)));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.volunteer_activism_outlined),
                title: Text('${MyStaticVariable.BookNowButton4label}'),
                onTap: () {
                  setState(() {
                    _selectedLink = MyStaticVariable.BookNowButton4link;
                    // isInternetConnected =true;
                    // alpha();
                  });
                  // Navigator.pop(context);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Screen4(
                  //         isInternetConnected: isInternetConnected,
                  //         link: _selectedLink)));
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.car_rental_sharp),
                title: Text('${MyStaticVariable.BookNowButton5label}'),
                onTap: () {
                  setState(() {
                    _selectedLink = MyStaticVariable.BookNowButton5link;
                    // isInternetConnected =true;
                    // alpha();
                  });
                  // Navigator.pop(context);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Screen4(
                  //         isInternetConnected: isInternetConnected,
                  //         link: _selectedLink)));
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
                    _selectedLink = MyStaticVariable.BookNowButton6link;
                    // isInternetConnected =true;
                    // alpha();
                  });
                  // Navigator.pop(context);
                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => Screen4(
                  //         isInternetConnected: isInternetConnected,
                  //         link: _selectedLink)));
                },
              ),
              Divider(),
              // ListTile(
              //   leading: Icon(Icons.close),
              //   title: Text('Close'),
              //   onTap: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

    @override
  Widget khan(BuildContext context) {
    print('idrees rebuild');

    return Screen4(
      isInternetConnected: widget.isInternetConnected, link: '${MyStaticVariable.BookNowButton1link}',
      // link: currentLink,
    );
  }
}

class ButtonData {
  String link;
  String label;

  ButtonData({required this.link, required this.label});
}
