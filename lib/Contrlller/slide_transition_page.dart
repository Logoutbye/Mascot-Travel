// import 'package:flutter/material.dart';

// class SlideTransitionPage extends PageRouteBuilder {
//   final Widget page;

//   SlideTransitionPage({required this.page})
//       : super(
//           pageBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//           ) =>
//               page,
//           transitionsBuilder: (
//             BuildContext context,
//             Animation<double> animation,
//             Animation<double> secondaryAnimation,
//             Widget child,
//           ) {
//             return SlideTransition(
//               position: Tween<Offset>(
//                 begin: const Offset(1.0, 0.0), // starting position
//                 end: Offset.zero, // ending position
//               ).animate(animation),
//               child: child,
//             );
//           },
//         );
// }



// // Navigator.push(
// //   context,
// //   SlideTransitionPage(page: Screen1()),
// // );


import 'package:flutter/material.dart';

class SlideTransitionPage extends PageRouteBuilder {
  final Widget page;
  final bool applySlideTransition;

  SlideTransitionPage({required this.page, this.applySlideTransition = true})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            if (applySlideTransition) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(1.0, 0.0), // starting position
                  end: Offset.zero, // ending position
                ).animate(animation),
                child: child,
              );
            } else {
              return child;
            }
          },
        );
}
