import 'dart:convert';
import 'dart:io';
import 'package:feedify/const.dart';
import 'package:feedify/feedsdk.dart';
import 'package:feedify/logs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kalingatv4/MyTabs.dart';
import 'package:kalingatv4/green_page.dart';
import 'package:kalingatv4/red_page.dart';
import 'package:kalingatv4/splash_screen.dart';
import 'package:kalingatv4/ui/NotificationArticleDetail.dart';
import 'package:kalingatv4/ui/article1.dart';
import 'package:kalingatv4/ui/articleDetail.dart';
import 'package:http/http.dart' as http;
import 'model/push_notification.dart';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
void main() async {
  initFeedSDK();
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // RemoteMessage _message = await FirebaseMessaging.instance.getInitialMessage();
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  // FirebaseMessaging.instance.subscribeToTopic("all");
  // OneSignal.shared.consentGranted(true);
  // OneSignal.shared.setAppId("1663ef4c-c218-4628-8820-688ab5d958c9");
  // OneSignal.shared.setNotificationOpenedHandler((result) {
  //   navigatorKey.currentState.push(
  //     MaterialPageRoute(
  //       builder: (context) => ArticleDetail('https://cdn.kalingatv.com/wp-content/uploads/2022/01/14674598230a7b3dea0d61139b238af5-750x430.jpg','Title Test','0-01-22','Descriptions','Link','Author','12'),
  //     ),
  //   );
  // });

  runApp(MyApp());
}
void initFeedSDK() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sdk = FeedSDK.getInstance(
      feedifyKey: '96H7Skal',
      feedifyDomain: 'http://kalingatv.com',
      feedifyUser: '5539');
  // if you want to show your own custom icon instead of Feedify's own icon
  FeedSDK.setNotificationIcon('asset://assets/images/kalinga_logo.png');
  // If FeedSDK.startScreen is set then all the notification payload data is passed to the startScreen
  FeedSDK.startScreen = 'ktv_notify';
  Logs.setEnabled(true);
  await sdk.init(
      appName: 'KalingaTvNews',
      projectId: 'kalingatvnews',
      firebaseCurrentApiKey: 'AIzaSyCsUW5b_r2_p-nGle_qTue78dKDGZoeOVE',
      firebaseMobileSdkAppId: '1:161695767908:android:76f1d8e8cc1fbb2edb2e71',
      firebaseStorageBucket: 'kalingatvnews.appspot.com',
      firebaseUrl: '',
      firebaseProjectNumber: '161695767908');
}
class MyApp extends StatefulWidget {
  //final Store<AppState> store;

  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => new _MyAppState();
}
final String LANDING_PAGE='landingpage';
final String NOTIFY_PAGE='notifypage';
class _MyAppState extends State<MyApp> {
  RemoteMessage message;
  bool visible = false ;
  PushNotification _notificationInfo;
  String title,image_url,description,id,date,link,author;
   final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  //MyApp();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      return GetMaterialApp(
        onGenerateRoute: (settings) {
          if (settings.name == FeedSDK.startScreen) {
            //final args = settings.arguments;
            // title=args[Constants];
            final args = settings.arguments as List<Map<String, String>>;
            var icon = args[0][Constants.icon];
            var title = args[0][Constants.title];
            var body = args[0][Constants.body];
            var type = args[0][Constants.type];
            Logs.d('CONSTANT DATA '+icon + title + body + type);

            // date=Constants.image;
            // description=Constants.body;
            // print('TTL : '+title);
            // print('DESC : '+description );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetail('0','cat',icon,
                    title,'', body, 'link','author','id','credit'),
              ),
            );
            Logs.d('onGenerateRoute $args');
          }
          return ;
        },
        home: SplashScreen(),
         navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "KalingaTV",
        // theme: ThemeData(
        //   brightness: Brightness.light,
        // fontFamily: "Montserrat",
        //fontFamily: "Roboto",
        // Dynamic font styles
        // textTheme: TextTheme(
        //   headline: TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0),
        //   body2: TextStyle(fontStyle: FontStyle.italic),
        // ),
        // ),
        routes: <String, WidgetBuilder>{
          LANDING_PAGE: (BuildContext context) => AllNews1(),
          //NOTIFY_PAGE: (BuildContext context) => PushArticleDetails('title', 'description', 'image_url'),
        },
        //   routes: {
        //     "red": (_) => RedPage(),
        //     "green": (_) => GreenPage(),
        //   },
         );
    //}
  }
}



//--------------------------------------------------------------------------------------------------------------------------------------------

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:odisha/red_page.dart';
// import 'package:odisha/services/local_notification_service.dart';
//
// import 'green_page.dart';
//
// ///Receive message when app is in background solution for on message
// Future<void> backgroundHandler(RemoteMessage message) async{
//   print('DATA :'+message.data.toString());
//   print('NOTIFI :'+message.notification.title);
// }
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   FirebaseMessaging.instance.subscribeToTopic("all");
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//       routes: {
//         "red": (_) => RedPage(),
//         "green": (_) => GreenPage(),
//       },
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key,  this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     LocalNotificationService.initialize(context);
//
//     ///gives you the message on which user taps
//     ///and it opened the app from terminated state
//     FirebaseMessaging.instance.getInitialMessage().then((message) {
//       if(message != null){
//         final routeFromMessage = message.data["route"];
//         // Navigator.push(
//         //   context,
//         //   MaterialPageRoute(
//         //     builder: (context) =>GreenPage(),
//         //   ),
//         // );
//         Navigator.of(context).pushNamed(routeFromMessage);
//       }
//     });
//
//     ///forground work
//     FirebaseMessaging.onMessage.listen((message) {
//       if(message.notification != null){
//         print(message.notification.body);
//         print(message.notification.title);
//       }
//
//       LocalNotificationService.display(message);
//     });
//
//     ///When the app is in background but opened and user taps
//     ///on the notification
//     FirebaseMessaging.onMessageOpenedApp.listen((message) {
//       print('Open Notification');
//       final routeFromMessage = message.data["route"];
//       Navigator.of(context).pushNamed(routeFromMessage);
//     });
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(18.0),
//         child: Center(
//             child: Text(
//               "You will receive message soon",
//               style: TextStyle(fontSize: 34),
//             )),
//       ),
//     );
//   }
// }
