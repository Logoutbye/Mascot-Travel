import 'package:ezeehome_webview/Screens/Screen4.dart';
import 'package:flutter/material.dart';

class Screen3Reloadable extends StatefulWidget {
  final bool isInternetConnected;
  // final String initialLink;

  Screen3Reloadable({
    required this.isInternetConnected,
  });
  void updateLink(String newLink) {
    print('idrees2');
  }

  @override
  _Screen3ReloadableState createState() => _Screen3ReloadableState();
}

class _Screen3ReloadableState extends State<Screen3Reloadable> {
  String currentLink = '';

  @override
  void initState() {
    print('idrees 3');
    widget.updateLink('newLink');
    updateLinkk('Hello');
    super.initState();
    // currentLink = widget.initialLink;
    // setState(() {
    //   print('idrees');
    // });
    print('idrees 4');
  }

  void updateLinkk(String newLink) {
    widget.updateLink('Alpha');
    setState(() {
      currentLink = newLink;
      print('idrees');
    });
  }

  @override
  Widget build(BuildContext context) {
    print('idrees rebuild');

    widget.updateLink('Hello');
    return Screen4(
      isInternetConnected: widget.isInternetConnected,
      link: currentLink,
    );
  }
}
