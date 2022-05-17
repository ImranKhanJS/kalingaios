import 'dart:async';
import 'dart:convert';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kalingatv4/ui/SearchPage.dart';
import 'package:kalingatv4/ui/live_video.dart';
import 'package:kalingatv4/ui/news_list_page.dart';
import 'package:kalingatv4/ui/settings.dart';
import 'package:kalingatv4/youtube/YoutubeHomeScreen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'model/categories_link_model.dart';
class MyTabs1 extends StatefulWidget {
  @override
  MyTabsState createState() => MyTabsState();
}
class MyTabsState extends State<MyTabs1> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
  //final String url = 'https://jsonplaceholder.typicode.com/posts'; //API url
    final String url='https://kalingatv.com/wp-admin/ktv_category.json';
  List specials;
  TabController controller;
  Color kalinga_color_code = const Color(0xff9b2219);
  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: myTabs.length);
    this.checkDataConnectivity();

//    this.getSpecials().then((jsonSpecials) {
//      setState(() {
//        specials = jsonSpecials;
//      });
//    });
  }
  Future<void> checkDataConnectivity() async {
    var result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      print("Connected");
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "No Internet",
        desc:
        "You are Offline.No Internet Conncection Please Connect To A Network!",
        style: AlertStyle(
          animationType: AnimationType.fromTop,
          titleStyle: TextStyle(
            color: kalinga_color_code,
            fontWeight: FontWeight.w900,
            fontSize: 30.0,
          ),
          descStyle: TextStyle(color: Colors.white, fontSize: 15.0),
        ),
        buttons: [
          DialogButton(
              color: Colors.grey,
              child: Text(
                "OK",
                style: TextStyle(fontSize: 20),
              ),
              width: 120,
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ).show();
    }
  }

  final List<Tab> myTabs = <Tab>[
      new Tab(
        text: "TOP STORIES",
      ),
      new Tab(
        text: "STATE",
      ),
      new Tab(
        text: "NATION",
      ),
      new Tab(
        text: "WORLD",
      ),
      new Tab(
        text: "ENTERTAINMENT",
      ),
      new Tab(
        text: "BUSINESS",
      ),
      new Tab(
        text: "SPORTS",
      ),
      new Tab(
        text: "TECH",
      ),
      new Tab(
        text: "OFF BEAT",
      ),
      new Tab(
        text: "MISCELLANY",
      ),
      new Tab(
        text: "FEATURES",
      ),
      new Tab(
        text: "VIDEOS",
      ),
    ];
    TabController _tabController;
    PageController pageController = PageController(initialPage: 0);
    StreamController<int> streamController = new StreamController<int>();
    StreamController<int> indexcontroller = StreamController<int>.broadcast();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<List> getSpecials() async {
    var response = await http.get(Uri.parse(url),
        headers: {"Accept": "application/json"});
    return jsonDecode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getSpecials(),
        builder: (context, snapshot) {
          //if (snapshot.hasData) {
            print(snapshot.data[0]);
            return MaterialApp(
                home: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: kalinga_color_code,
                    elevation: 0,
                    iconTheme: IconThemeData(color: kalinga_color_code),
                    actions: [
                      Builder(
                        builder: (context) => IconButton(
                          icon: Icon(Icons.menu,color:Colors.white),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                        ),
                      ),
                    ], // Set menu
                    title: Row(
                      children: [
                        Image.asset(
                          'images/Kalinga-TV-Logo.png',
                          fit: BoxFit.contain,
                          height: 50,
                        ),
                        // Image.asset(
                        //   'images/livetv.jpg',
                        //   fit: BoxFit.contain,
                        //   height: 50,
                        //   width: 60,
                        // ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.live_tv,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => VideoPlayerScreen()),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.search_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SearchPage(),),
                            );
                          },
                        )
                      ],

                    ),
                    //title: Text("KalingaTV"),
                    //centerTitle: true,
                  ),
                  key:_drawerscaffoldkey,
                  endDrawer: new Drawer(
                      child: new ListView(
                        children: <Widget>[
                          new Container(
                            child: new Image.asset('images/Kalinga-TV-Logo.png'),
                            color: kalinga_color_code ,
                            height: 120.0,),
                          new ListTile(

                            leading: new Icon(Icons.trending_up,color:Colors.grey[800] ,),
                            title: new Text("Top Stories",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(0);
                              Navigator.pop(context);
                              //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(

                            leading: new Icon(Icons.trending_up,color:Colors.grey[800] ,),
                            title: new Text("State",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(1%12);
                              Navigator.pop(context);
                              //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(

                            leading: new Icon(Icons.location_city_rounded,color:Colors.grey[800] ,),
                            title: new Text("Nation",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(2%12);
                              Navigator.pop(context);
                              //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(

                            leading: new Icon(Icons.location_city_rounded,color:Colors.grey[800] ,),
                            title: new Text("World",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(3%12);
                              Navigator.pop(context);
                              //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.public_rounded,color: Colors.grey[800] ,),
                            title: new Text("Entertainment",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              //pageController.animateTo(pageController.initialPage+1);
                              _tabController.animateTo(4%12);
                              Navigator.pop(context);
                              //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.panorama_photosphere_select,color: Colors.grey[800] ,),
                            title: new Text("Business"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(5%12);
                              Navigator.pop(context);
                              //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.movie,color: Colors.grey[800] ,),
                            title: new Text("Sports"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(6%12);
                              Navigator.pop(context);
                              //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.business_center_rounded,color: Colors.grey[800] ,),
                            title: new Text("Tech"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(7%12);
                              Navigator.pop(context);
                              //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.sports_bar_rounded,color: Colors.grey[800] ,),
                            title: new Text("Offbeat"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(8%12);
                              Navigator.pop(context);
                              //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.more,color: Colors.grey[800],),
                            title: new Text("Miscellany"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(9%12);
                              //Navigator.pop(context);
                              //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.more,color: Colors.grey[800],),
                            title: new Text("Features"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              _tabController.animateTo(10%12);
                              //Navigator.pop(context);
                              //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.video_collection,color: Colors.grey[800],),
                            title: new Text("Videos"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),
                            onTap: () {
                              _tabController.animateTo(11%12);
                              Navigator.pop(context);
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.search,color: Colors.grey[800],),
                            title: new Text("Search"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              //_tabController.animateTo(9%10);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchPage(),
                                ),
                              );
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.live_tv,color: Colors.grey[800],),
                            title: new Text("Live"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              //_tabController.animateTo(9%10);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VideoPlayerScreen(),
                                ),
                              );
                            },
                          ),
                          new ListTile(
                            leading: new Icon(Icons.settings,color: Colors.grey[800],),
                            title: new Text("Settings"
                              ,
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                              ),),

                            onTap: () {
                              //_tabController.animateTo(9%10);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingsApp(),
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                  body: PageView(
                    onPageChanged: (index) {
                      indexcontroller.add(index);
                    },
                    controller: pageController,
                    children: <Widget>[
                      Center(
                          child: SafeArea(
                            child: Stack(
                              children: <Widget>[
                                CustomScrollView(
                                  slivers: <Widget>[
                                    SliverToBoxAdapter(
                                        child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Column(children: <Widget>[
                                              DefaultTabController(
                                                  length: 7, // length of tabs
                                                  initialIndex: 1,
                                                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                                    Container(
                                                      color: kalinga_color_code,
                                                      child: new TabBar(
                                                        isScrollable: true,
                                                        controller: _tabController,
                                                        tabs: myTabs,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: MediaQuery.of(context).size.height,
                                                      //     decoration: BoxDecoration(
                                                      //     border: Border(top: BorderSide(color: Colors.grey, width: 0.5))
                                                      // ),
                                                      child: new TabBarView(
                                                          controller: _tabController,
                                                          children: <Widget>[
                                                            // news_list_page('Top',snapshot.data[0]["link"]),
                                                            // //news_list_page('Top','https://kalingatv.com/wp-json/wp/v2/posts?categories=19&categories=18985&categories=17870&categories=1070&categories=2938&categories=26&categories=22&categories=17872&categories=17873&categories=376&per_page=50&_embed'),
                                                            // //TopTabPage('top'),
                                                            // news_list_page('state',snapshot.data[1]["link"]),
                                                            // news_list_page('nation',snapshot.data[2]["link"]),
                                                            // news_list_page('world',snapshot.data[3]["link"]),
                                                            // news_list_page('entertain',snapshot.data[4]["link"]),
                                                            // news_list_page('business',snapshot.data[5]["link"]),
                                                            // news_list_page('sports',snapshot.data[6]["link"]),
                                                            // news_list_page('tech',snapshot.data[7]["link"]),
                                                            // news_list_page('offbeat',snapshot.data[8]["link"]),
                                                            // news_list_page('miscellany',snapshot.data[9]["link"]),
                                                            // news_list_page('features',snapshot.data[10]["link"]),
                                                            // YoutubeHomeScreen()
                                                            //news_list_page('Top',(_postList.length > 0 ? _postList[0].link : _postList[0].link)),
                                                            // news_list_page('Top',(_postList.length > 0 ? _postList[0].link : 'https://kalingatv.com/wp-json/wp/v2/posts?categories=19&categories=18985&categories=17870&categories=1070&categories=2938&categories=26&categories=22&categories=17872&categories=17873&categories=376&per_page=50&_embed')),
                                                            // //news_list_page('Top','https://kalingatv.com/wp-json/wp/v2/posts?categories=19&categories=18985&categories=17870&categories=1070&categories=2938&categories=26&categories=22&categories=17872&categories=17873&categories=376&per_page=50&_embed'),
                                                            // //TopTabPage('top'),
                                                            // news_list_page('state',(_postList.length > 0 ? _postList[1].link : '')),
                                                            // news_list_page('nation',(_postList.length > 0 ? _postList[2].link : '')),
                                                            // news_list_page('world',(_postList.length > 0 ? _postList[3].link : '')),
                                                            // news_list_page('entertain',(_postList.length > 0 ? _postList[4].link : '')),
                                                            // news_list_page('business',(_postList.length > 0 ? _postList[5].link : '')),
                                                            // news_list_page('sports',(_postList.length > 0 ? _postList[6].link : '')),
                                                            // news_list_page('tech',(_postList.length > 0 ? _postList[7].link : '')),
                                                            // news_list_page('offbeat',(_postList.length > 0 ? _postList[8].link : '')),
                                                            // news_list_page('miscellany',(_postList.length > 0 ? _postList[9].link : '')),
                                                            // news_list_page('features',(_postList.length > 0 ? _postList[10].link : '')),
                                                            // YoutubeHomeScreen()
                                                            // TopTabPage('top'),
                                                            // news_list_page('state','19'),
                                                            // news_list_page('nation','18985'),
                                                            // news_list_page('world','17870'),
                                                            // news_list_page('entertain','1070'),
                                                            // news_list_page('business','2938'),
                                                            // news_list_page('sports','26'),
                                                            // news_list_page('tech','22'),
                                                            // news_list_page('offbeat','17872'),
                                                            // news_list_page('miscellany','17873'),
                                                            // news_list_page('features','376'),
                                                            // YoutubeHomeScreen()
                                                          ]
                                                      ),
                                                    )
                                                  ])
                                              ),
                                            ],
                                            )
                                        )
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          )
                        //child: Text('Home'),
                      ),
                    ],
                  ),
                ));
          //}
          // else {
          //   return Container(
          //       height: double.infinity,
          //       color: Colors.white,
          //       child: Center(child: CircularProgressIndicator(
          //         valueColor: new AlwaysStoppedAnimation<Color>(kalinga_color_code),
          //       )),
          //   );
          //     }
        });
  }
}