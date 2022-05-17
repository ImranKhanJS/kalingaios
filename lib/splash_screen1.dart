import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen1 extends StatefulWidget {

  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen1>
    with SingleTickerProviderStateMixin {
  String matchLoginStatus;
  var _visible = true;
  Color kalinga_color_code = const Color(0xff9b2219);
  AnimationController animationController;
  Animation<double> animation;

  // CHANGE THIS parameter to true if you want to test GDPR privacy consent

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
   // Navigator.of(context).pushNamed(LANDING_PAGE);
  }

  @override
  void initState() {
    super.initState();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: android.smallIcon,
    //           ),
    //         )
    //     );
    //   }
    // });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(notification.body)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    // animationController = new AnimationController(
    //     vsync: this, duration: new Duration(seconds: 2));
    // animation =
    // new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    //
    // animation.addListener(() => this.setState(() {}));
    // animationController.forward();
    //
    // setState(() {
    //   _visible = !_visible;
    // });
    // startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage("images/flash_screen.png"),
                fit: BoxFit.fill,),),
            // child: Center(
            //   child:Text("Flutter Example",
            //       style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //           fontSize: 28.0,
            //           color: Colors.red)),)

        )
      // body: Stack(
      //   fit: StackFit.expand,
      //   children: <Widget>[
      //     new Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: <Widget>[
      //         new Image.asset(
      //           'images/kalinga-tv-channel-logo.jpg',
      //           width: animation.value * 250,
      //           height: animation.value * 250,
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}