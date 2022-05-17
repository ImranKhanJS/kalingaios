import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kalingatv4/MyTabs.dart';
import 'package:kalingatv4/rateapp/button_widget.dart';
import 'package:kalingatv4/rateapp/rate_app_init_widget.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:flutter/material.dart';
//import 'package:notification_permissions/notification_permissions.dart';
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'article1.dart';
import 'rounded_bordered_container.dart';
class SettingsApp extends StatelessWidget {
  static final String title = 'Rate My App';

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: title,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.red),
    home: RateAppInitWidget(
      builder: (rateMyApp) => Settings(rateMyApp: rateMyApp),
    ),
  );
}
class Settings extends StatefulWidget {
  final RateMyApp rateMyApp;
  const Settings({
    Key key,
     this.rateMyApp,
  }) : super(key: key);

  @override
  SettingsState createState() => SettingsState();
}
class SettingsState extends State<Settings> {
  bool isSwitchedFT = false;
  RateMyApp rateMyApp;
  Future<String> permissionStatusFuture;
  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";
  bool visible = false ;
  bool isSwitched = true;
  Color kalinga_color_code = const Color(0xff9b2219);
  String name,email,mobile;
  String comment = '';
  void initState() {
    super.initState();
    getSwitchValues();
    //permissionStatusFuture = getCheckNotificationPermStatus();
    // With this, we will be able to check if the permission is granted or not
    // when returning to the application
    //WidgetsBinding.instance.addObserver(this);
  }
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     setState(() {
  //       permissionStatusFuture = getCheckNotificationPermStatus();
  //     });
  //   }
  // }
  // Future<String> getCheckNotificationPermStatus() {
  //   return NotificationPermissions.getNotificationPermissionStatus()
  //       .then((status) {
  //     switch (status) {
  //       case PermissionStatus.denied:
  //         return permDenied="dnd";
  //       case PermissionStatus.granted:
  //         return permGranted="grnt";
  //       // case PermissionStatus.unknown:
  //       //   return permUnknown;
  //       // case PermissionStatus.provisional:
  //       //   return permProvisional;
  //       // default:
  //       //   return null;
  //     }
  //   });
  // }
  getSwitchValues() async {
    isSwitchedFT = await getSwitchState();
    setState(() {});
  }
  // Future<bool> saveSwitchState(bool value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setBool("switchState", value);
  //   print('Switch Value saved $value');
  //   if(value==true)
  //   {
  //     OneSignal.shared.setSubscription(false);
  //     //FirebaseMessaging.instance.unsubscribeFromTopic ('all');
  //     //FirebaseMessaging.instance.subscribeToTopic ('all');
  //   }
  //   if(value==false)
  //   {
  //     OneSignal.shared.setSubscription(true);
  //     //OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
  //     //FirebaseMessaging.instance.unsubscribeFromTopic ('all');
  //     //FirebaseMessaging.instance.subscribeToTopic ('all');
  //   }
  //   return prefs.setBool("switchState", value);
  // }

  Future<bool> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isSwitchedFT = prefs.getBool("switchState");
    print(isSwitchedFT);

    return isSwitchedFT;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kalinga_color_code,
        elevation: 0,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () {
            //Navigator.pop(context, true);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AllNews1(),
              ),
            );
          },
        ),
        iconTheme: IconThemeData(color: kalinga_color_code),
        title: Row(
          children: [
            Image.asset(
              'images/Kalinga-TV-Logo.png',
              fit: BoxFit.contain,
              height: 50,
            ),
          ],

        ),
        //title: Text("KalingaTV"),
        //centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                       ListTile(
                        leading: Icon(Icons.notifications),
                        title: Text('Notification'),
                        //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                            trailing: Wrap(
                              children: <Widget>[
                                Switch(
                                  value: isSwitchedFT,
                                  onChanged: (bool value) {
                                    setState(() {
                                      isSwitchedFT = value;
                                      //saveSwitchState(value);
                                      print('Saved state is $isSwitchedFT');
                                      //switch works
                                    });
                                    print(isSwitchedFT);
                                  },
                                  activeTrackColor: Colors.grey[200],
                                  activeColor: Colors.grey,
                                  inactiveThumbColor: kalinga_color_code,
                                  inactiveTrackColor: Colors.red[50],
                                ),
                              ],
                            ),
                       ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     child: ListTile(
                      //       leading: Icon(Icons.add),
                      //       title: Text('Font'),
                      //       trailing: Wrap(
                      //         spacing: 20, // space between two icons
                      //         children: <Widget>[
                      //           Icon(Icons.font_download_rounded,size: 25), // icon-1
                      //           Icon(Icons.font_download_rounded,size: 20),
                      //           Icon(Icons.font_download_rounded,size: 15),// icon-2
                      //         ],
                      //       ),
                      //       // subtitle: Text('This is subtitle'),
                      //       selected: true,
                      //       onTap: () {
                      //         setState(() {
                      //           //txt='List Tile pressed';
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // ListTile(
                      //   // trailing: FittedBox(
                      //   //   fit: BoxFit.fill,
                      //   //   child: Row(
                      //   //     children: <Widget>[
                      //   //       Icon(Icons.font_download_rounded,size: 25), // icon-1
                      //   //       Icon(Icons.font_download_rounded,size: 20),
                      //   //       Icon(Icons.font_download_rounded,size: 15),
                      //   //     ],
                      //   //   ),
                      //   // ),
                      //   leading: Icon(Icons.add),
                      //          title: Text('Font'),
                      //   trailing: Wrap(
                      //   spacing: 30, // space between two icons
                      //   children: <Widget>[
                      //     Icon(Icons.font_download_rounded,size: 25), // icon-1
                      //     Icon(Icons.font_download_rounded,size: 20),
                      //     Icon(Icons.font_download_rounded,size: 15),// icon-2
                      //   ],
                      // ),
                      // ),
                      // ListTile(
                      //   //leading: Icon(Icons.font_download_rounded),
                      //   title: Text('Font'),
                      //   //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                      // ),
                      // ListTile(
                      //   leading: Icon(Icons.font_download_rounded,size: 10,),
                      // ),
                      // ListTile(
                      //   leading: Icon(Icons.font_download_rounded,size: 15,),
                      // ),
                      // ListTile(
                      //   leading: Icon(Icons.font_download_rounded,size: 20,),
                      // ),
                       ListTile(
                        leading: Icon(Icons.share_rounded),
                        title: Text("Share"),
                         onTap: () {
                         _onShareLink(context);
                         },
                      ),
                      //  ButtonWidget(
                      //   text: 'Rate App',
                      //   onClicked: () => widget.rateMyApp.showRateDialog(
                      //     context,
                      //     contentBuilder: (context, _) => buildComment(context),
                      //     actionsBuilder: actionsBuilder,
                      //   ),
                      // ),
                      ListTile(
                        leading: Icon(Icons.rate_review),
                        title: Text("Rate & Review"),
                        onTap: ()  => widget.rateMyApp.showRateDialog(
                          context,
                          contentBuilder: (context, _) => buildComment(context),
                          actionsBuilder: actionsBuilder,
                        ),
                      ),
                      // Builder(
                      //   builder: (BuildContext context) {
                      //     return RaisedButton(
                      //       child: const Text('Share With Empty Origin'),
                      //       onPressed: () => _onShareLink(context),
                      //     );
                      //   },
                      // ),
                       ListTile(
                        leading: Icon(Icons.feedback_rounded),
                        title: Text('Feedback'),
                        onTap: (){
                          showDialog(context: context,
                              builder: (BuildContext context) {
                                return _CustomDialogBoxState();
                              });
                        },
                        //subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  // void rateApp()
  // {
  //   widget.rateMyApp.showRateDialog(
  //     context,
  //     contentBuilder: (context, _) => buildComment(context),
  //     actionsBuilder: actionsBuilder,
  //   );
  //    RateMyAppBuilder(
  //     rateMyApp: RateMyApp(
  //       googlePlayIdentifier: 'com.android.chrome',
  //       appStoreIdentifier: 'com.apple.mobilesafari',
  //       minDays: 0,
  //       minLaunches: 2,
  //       // remindDays: 1,
  //       // remindLaunches: 1,
  //     ),
  //     onInitialized: (context, rateMyApp) {
  //       setState(() => this.rateMyApp = rateMyApp);
  //
  //       if (rateMyApp.shouldOpenDialog) {
  //         rateMyApp.showRateDialog(context);
  //       }
  //     },
  //     builder: (context) => rateMyApp == null
  //         ? Center(child: CircularProgressIndicator())
  //         : widget.builder(rateMyApp),
  //   );
  // }
  Widget buildComment(BuildContext context) => TextFormField(
    autofocus: true,
    onFieldSubmitted: (_) => Navigator.of(context).pop(),
    maxLines: 3,
    decoration: InputDecoration(
      hintText: 'Write Comment...',
      border: OutlineInputBorder(borderSide: BorderSide(),),
    ),
    onChanged: (comment) => setState(() => this.comment = comment),
  );

  List<Widget> actionsBuilder(BuildContext context) =>
      [buildOkButton(), buildCancelButton()];

  Widget buildOkButton() => RateMyAppRateButton(
    widget.rateMyApp,
    text: 'SEND',
    callback: () {
      // print('Comment: $comment');
    },
  );

  Widget buildCancelButton() => RateMyAppNoButton(
    widget.rateMyApp,
    text: 'CANCEL',
  );
  _onShareLink(BuildContext context) async {
   //  setState(() {
   //    visible = true;
   //  });
   //  var url = 'http://intentitsolutions.com/kalingatv/API/getLink.php';
   //  var response = await http.post(url, body: {
   //
   //  });
   //  var message = jsonDecode(response.body);
   // String slink=message[0]['link'];
   //  setState(() {
   //    visible = false;
   //  });
    await Share.share("www.kalingatv.com");
  }

  // void changeFontSize() async{
  //   setState(() {
  //     custFontSize+=2;
  //   });
  // }
  // Future sharedLink() async {
  //   // Showing CircularProgressIndicator.
  //   setState(() {
  //     visible = true;
  //   });
  //   var url = 'http://intentitsolutions.com/kalingatv/API/getLink.php';
  //   var response = await http.post(url, body: {
  //
  //   });
  //   var message = jsonDecode(response.body);
  //   String slink=message[0]['link'];
  //     setState(() {
  //       visible = false;
  //     });
  // }
}

class _CustomDialogBoxState extends StatelessWidget {
  Color kalinga_color_code = const Color(0xff9b2219);
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      child: contentBox(context),
    );
  }
    contentBox(context) {
      return SingleChildScrollView(
        child: Stack(
          children: <Widget>[
        Positioned(
        right: 20.0,
        top: 8,
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              radius: 14.0,
              backgroundColor: Colors.white,
              child: Icon(Icons.cancel,size: 40,color: kalinga_color_code),
            ),
          ),
        ),
      ),
      Container(
      padding: EdgeInsets.only(left: 20,top: 45
      , right: 20,bottom: 20
      ),
      margin: EdgeInsets.only(top: 45),
      decoration: BoxDecoration(
      shape: BoxShape.rectangle,
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
      BoxShadow(color: Colors.transparent,offset: Offset(0,10),
      blurRadius: 10
      ),
      ]
      ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Text(
                  "Your FeedBack!",
                  textAlign: TextAlign.center,
                  textScaleFactor: 2.0,
                  style: TextStyle(
                      color: kalinga_color_code,
                      fontSize: 15.0
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Mobile',
                    hintText: 'Enter Your Mobile No.',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'FeedBack',
                    hintText: 'Enter FeedBack',
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                // textColor: Colors.white,
                // color: kalinga_color_code,
                child: Text('Send'),
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Sent FeedBack"),
                        // Retrieve the text which the user has entered by
                        // using the TextEditingController.
                        content: Text(nameController.text),
                        actions: <Widget>[
                          new TextButton(
                            child: new Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              )
            ],
        )
      )
        ]
        ) );
    }
  }

