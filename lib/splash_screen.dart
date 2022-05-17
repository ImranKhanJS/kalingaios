import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kalingatv4/MyTabs.dart';
import 'package:kalingatv4/main.dart';
import 'package:kalingatv4/ui/article1.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String matchLoginStatus;
  var _visible = true;
  Color kalinga_color_code = const Color(0xff9b2219);
  AnimationController animationController;
  Animation<double> animation;
  String _debugLabelString = "";
  String _emailAddress;
  String _smsNumber;
  String _externalUserId;
  bool _enableConsentButton = false;
  bool _requireConsent = true;
  // static final String oneSignalAppId='1663ef4c-c218-4628-8820-688ab5d958c9';
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }
  void navigationPage() {
    //Navigator.of(context).pushNamed(LANDING_PAGE);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllNews1(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //initPlatformState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }
  // void configOneSignel()
  // {
  //   //OneSignal.shared.init('4805d537-3690-4473-b740-430e55d61505');
  //   await OneSignal.shared
  //       .setAppId("fb18a5a7-0f1b-4433-8b1c-8e12ac9025f5");
  //
  // }
  // Future<void> initPlatformState() async{
  //   await OneSignal.shared
  //       .init(oneSignalAppId);
  //   OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
  //   OneSignal.shared.setNotificationOpenedHandler((result) {
  //     var data=result.notification.payload.additionalData;
  //     navigatorKey.currentState.pushAndRemoveUntil(
  //         MaterialPageRoute(builder: (context) =>
  //             PushArticleDetails(data['post_id'].toString())),
  //             (Route<dynamic> route) => false);
  //   });
  // }
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