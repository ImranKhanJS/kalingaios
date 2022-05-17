import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kalingatv4/model/Categories.dart';
import 'package:kalingatv4/model/categories_link_model.dart';
import 'package:kalingatv4/model/social.dart';
import 'package:kalingatv4/rateapp/rate_app_init_widget.dart';
import 'package:kalingatv4/services/Services.dart';
import 'package:kalingatv4/ui/TopTabPage.dart';
import 'package:kalingatv4/ui/settings.dart';
import 'package:kalingatv4/ui/settings1.dart';
import 'package:kalingatv4/youtube/YoutubeHomeScreen.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher.dart';
import 'SearchPage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:kalingatv4/rateapp/rate_app_init_widget.dart';
import 'articleDetail.dart';
import 'live_video.dart';
import 'news_list_page.dart';
import 'package:http/http.dart' as http;
class AllNews1 extends StatefulWidget {
  final RateMyApp rateMyApp;
  const AllNews1({
    Key key,
     this.rateMyApp,
  }) : super(key: key);
  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews1> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final GlobalKey<ScaffoldState> _drawerscaffoldkey = new GlobalKey<ScaffoldState>();
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
   Color kalinga_color_code = const Color(0xff9b2219);
  List<categories_link_model> _postList =new List<categories_link_model>();
  //List<categories_link_model> _postTopNews =new List<categories_link_model>();
  int p_incr=1;
  @override
  void initState() {
    super.initState();
    //_getTopNews();
    _getLink();
    // _tabController = new TabController(vsync: this, length: _postList.length);
    this.checkDataConnectivity();
  }
  _makingPhoneCall(String phone) async {
    String url = 'tel:'+phone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _openSocial(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
  // Future<List<categories_link_model>> _getTopNews() async {
  //    var data = await http.get(Uri.parse("https://kalingatv.com/wp-admin/category/link/ktv_category.json"));
  //   //var data = await http.get(Uri.parse('http://intentitsolutions.com/P365TECH/api/getAllSubcategory.php?id=87'));
  //   //var data = await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/categories?per_page=100&_embed"));
  //   if (data.statusCode == 200) {
  //     //print('SUBCAT :'+data.body.toString());
  //     setState(() {
  //       _postTopNews = parseTopNews(data.body);
  //       //_tabController = new TabController(vsync: this, length: _postList.length);
  //       //print('News Data :'+data.body.toString());
  //       // tabController =
  //       //     TabController(length: _postList.length??'', vsync: this, initialIndex: 0);
  //       //print('CONTROLLER '+tabController.length.toString());
  //       // clength=_postList.length??'';
  //     }
  //     );
  //     //print('CL '+_postList.length.toString()+' SCAT :'+_postList[1].subcategory);
  //     return _postTopNews;
  //     //return list;
  //   } else {
  //     throw Exception("Error");
  //   }
  //   //print('CL :'+clength.toString());
  // }
  // static List<categories_link_model> parseTopNews(String responseBody) {
  //   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  //   return parsed.map<categories_link_model>((json) => categories_link_model.fromJson(json)).toList();
  // }
  Future<List<categories_link_model>> _getLink() async {
     var data = await http.get(Uri.parse("https://kalingatv.com/wp-admin/category/link/tab_category.json"));
    //var data = await http.get(Uri.parse('http://intentitsolutions.com/P365TECH/api/getAllSubcategory.php?id=87'));
    //var data = await http.get(Uri.parse("https://kalingatv.com/wp-json/wp/v2/categories?per_page=100&_embed"));
    if (data.statusCode == 200) {
      //print('SUBCAT :'+data.body.toString());
      setState(() {
        _postList = parseCategory(data.body);
        // for(int i=0; i<_postList.length; i++)
        //   {
        //     if(_postList[i].name=='Videos')
        //     {
        //       _postList[i].link='YoutubeHomeScreen()';
        //     }
            // if(_postList[i].name=='Education')
            // {
            //   _postList.removeAt(i);
            // }
            // if(_postList[i].name=='Uncategorized')
            // {
            //   _postList.removeAt(i);
            // }
            // if(_postList[i].name=='Founder')
            // {
            //   _postList.removeAt(i);
            // }
          //}
        _tabController = new TabController(vsync: this, length: _postList.length);
        //print('News Data :'+data.body.toString());
        // tabController =
        //     TabController(length: _postList.length??'', vsync: this, initialIndex: 0);
        //print('CONTROLLER '+tabController.length.toString());
        // clength=_postList.length??'';
      });
      //print('CL '+_postList.length.toString()+' SCAT :'+_postList[1].subcategory);
      return _postList;
      //return list;
    } else {
      throw Exception("Error");
    }
    //print('CL :'+clength.toString());
  }
  static List<categories_link_model> parseCategory(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<categories_link_model>((json) => categories_link_model.fromJson(json)).toList();
  }
  // final List<Tab> myTabs = <Tab>[
  //   new Tab(
  //     text: "TOP STORIES",
  //   ),
  //   new Tab(
  //     text: "STATE",
  //   ),
  //   new Tab(
  //     text: "NATION",
  //   ),
  //   new Tab(
  //     text: "WORLD",
  //   ),
  //   new Tab(
  //     text: "ENTERTAINMENT",
  //   ),
  //   new Tab(
  //     text: "BUSINESS",
  //   ),
  //   new Tab(
  //     text: "SPORTS",
  //   ),
  //   new Tab(
  //     text: "TECH",
  //   ),
  //   new Tab(
  //     text: "OFF BEAT",
  //   ),
  //   new Tab(
  //     text: "MISCELLANY",
  //   ),
  //   new Tab(
  //     text: "FEATURES",
  //   ),
  //   new Tab(
  //     text: "VIDEOS",
  //   ),
  // ];
   //TabController _tabController;
  PageController pageController = PageController(initialPage: 0);
  StreamController<int> streamController = new StreamController<int>();
  StreamController<int> indexcontroller = StreamController<int>.broadcast();
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
  Future<bool> showExitPopup(context) async{
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.red.shade800),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              print('no selected');
                              Navigator.of(context).pop();
                            },
                            child: Text("No", style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var statusBarHeight = MediaQuery.of(context).padding.top;
    var appBarHeight = kToolbarHeight;
    return WillPopScope(
        onWillPop: () => showExitPopup(context),
      child:Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: kalinga_color_code,
            elevation: 0,
            // iconTheme: IconThemeData(color: kalinga_color_code),
            // leading:Builder(
            //   builder: (context) => IconButton(
            //     icon: Icon(Icons.menu,color:Colors.white),
            //     onPressed: () => Scaffold.of(context).openDrawer(),
            //     //tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            //   ),
            // ) ,
            // actions: [
            //   Builder(
            //     builder: (context) => IconButton(
            //       icon: Icon(Icons.menu,color:Colors.white),
            //       onPressed: () => Scaffold.of(context).hasEndDrawer,
            //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            //     ),
            //   ),
            // ], // Set menu
            title: Image.asset(
              'images/latest_ktv_header_logo2.jpeg',
              fit: BoxFit.contain,
              height: 40,
            ),
            actions: [
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
              // SizedBox(
              //   width: 10,
              // ),
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
              ),
      Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu,color:Colors.white),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
            ],
            //title: Text("KalingaTV"),
            //centerTitle: true,
          ),

         // body:Scaffold(
            //second scaffold
            key:_drawerscaffoldkey,
        endDrawer:
        //Drawer(
    Container(
        //padding: EdgeInsets.only(top: statusBarHeight+ appBarHeight + 1),//adding one pixel for appbar shadow
        //width: MediaQuery.of(context).size.width,
      child:Drawer(
        child:ListView(
         children: [
          Container(
            color: kalinga_color_code,
          height: 80,
           child:Row(
             children: [
           DrawerHeader(
            child: Container(
              child:FutureBuilder<List<social>>(
                future: Services.getSocial(),
                builder: (context, snapshot5) {
                  // not setstate here
                  //
                  if (snapshot5.hasError) {
                    return Text('Error ${snapshot5.error}');
                  }
                  //
                  if (snapshot5.hasData) {
                    streamController.sink.add(snapshot5.data.length);
                    // gridview
                    return ListView.builder(
                      //physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot5.data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index)
                      {
                        return GestureDetector(
                          onTap: (){
                            if(snapshot5.data[index].name=='call')
                            {
                              _makingPhoneCall(snapshot5.data[index].link);
                            }
                            else {
                              _openSocial(snapshot5.data[index].link);
                            }
                          },
                          // child:Container(
                          //     width: 30,
                          //     height:30,
                          //     child:Text(snapshot5.data[index].)
                          // ),
                          child:Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            width: 30,
                            height:30,
                            child:Image.network(
                              snapshot5.data[index].icon,
                            ),),
                        );
                      },
                    );
                  }
                  return circularProgress();
                },
              ),),
            decoration: BoxDecoration(
              color: kalinga_color_code,
            ),
          ),
               Spacer(
               ),
               Container(
                 //width: double.infinity,
                 color: kalinga_color_code,
                 alignment: Alignment.centerRight,
                 child: IconButton(
                   icon: Icon(
                     Icons.power_settings_new,
                     color: Colors.white,
                   ),
                   onPressed: () {
                     Navigator.pop(context);
                   },
                 ),
               ),
             ],),
          ),
        // new Container(
        //                 width:double.infinity,
        //                 child: new Image.asset('images/Kalinga-TV-Logo.png',fit: BoxFit.fill,),
        //                 color: kalinga_color_code ,
        //                 height: 100.0,),
           Container(
             // constraints: BoxConstraints(
             //   maxHeight: double.infinity,
             // ),
           child:Column(
               //mainAxisSize: MainAxisSize.min,
          children:
        List<Widget>.generate(_postList.length, (int index){
          // setState(() {
          //   _postList[0].name=_postTopNews[0].name??'No Name';
          //   _postList[0].link=_postTopNews[0].link??'No Link';
          //   //this.cat_id=_postList[index].category??'';
          //   //print('CAT_ID '+cat_id);
          // });
          //print('CT_ITEM '+categry);
          //return new Text("again some random text :"+_postList[index].subcat_id+' '+_postList[index].subcategory);
          // if(index==0)
          //   {
          //     return ListTile(
          //       // leading: Container(
          //       //   height: 20,
          //       //   width: 20,
          //       //   child: CachedNetworkImage(
          //       //     //fit: BoxFit.fill,
          //       //     imageUrl: _postList[index].icon,
          //       //     //placeholder: (context, url) =>Loader()
          //       //   ),),
          //       //leading: new Icon(Icon._postList[index].icon,color:Colors.grey[800] ,),
          //       title: Column(
          //         children: [
          //            Text('Menu',
          //             style: TextStyle(
          //               fontFamily: 'Poppins',
          //               fontStyle: FontStyle.normal,
          //               fontSize: 16,
          //               color: kalinga_color_code,
          //               fontWeight: FontWeight.w500,
          //             ),),
          //           Divider(
          //             height: 1,
          //             thickness: 0.5,
          //             color: Colors.grey,
          //           ),
          //         ],
          //       ),
          //
          //       onTap: () {
          //         _tabController.animateTo(0);
          //         Navigator.pop(context);
          //         //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
          //       },
          //     );
          //   }
          //else {
            return ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              // leading: Container(
              //   // height: 20,
              //   // width: 20,
              //   child: CachedNetworkImage(
              //     //fit: BoxFit.fill,
              //     imageUrl: _postList[index].icon,
              //     //placeholder: (context, url) =>Loader()
              //   ),
              // ),
              //leading: new Icon(Icon._postList[index].icon,color:Colors.grey[800] ,),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
              new Text(_postList[index].name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                  color: kalinga_color_code,
                  fontWeight: FontWeight.w500,
                ),),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
              ],
              ),

              onTap: () {
                //int indexIncr=_postList[index] + 1;
                _tabController.animateTo((index)%(_postList.length));
                Navigator.pop(context);
                //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
              },
            );
          //}

        }),),
           ),
        // ListTile(
        //   leading: Container(
        //     height: 20,
        //     width: 20,
        //     child: Icon(Icons.video_collection,color:kalinga_color_code ,),
        //   ),
        //   //leading: new Icon(Icon._postList[index].icon,color:Colors.grey[800] ,),
        //   title: new Text('Video',
        //     style: TextStyle(
        //       fontFamily: 'Poppins',
        //       fontStyle: FontStyle.normal,
        //       fontSize: 16,
        //       color: kalinga_color_code,
        //       fontWeight: FontWeight.w500,
        //     ),),
        //
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => YoutubeHomeScreen(),
        //       ),
        //     );
        //     //int indexIncr=_postList[index] + 1;
        //     // _tabController.animateTo((index)%(_postList.length));
        //     // Navigator.pop(context);
        //     //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
        //   },
        // ),
        //    Divider(
        //      height: 1,
        //      thickness: 0.5,
        //      color: Colors.grey,
        //    ),
           ListTile(
             leading: new Icon(Icons.settings,color: kalinga_color_code,),
             title: new Text("Settings"
               ,
               style: TextStyle(
                 fontFamily: 'Poppins',
                 fontStyle: FontStyle.normal,
                 fontSize: 16,
                 color: kalinga_color_code,
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
           Divider(
             height: 1,
             thickness: 0.5,
             color: Colors.grey,
           ),
         ],
        ),
      ),),
        //),
      // drawer: new Drawer(
      //           child: new ListView(
      //             children: <Widget>[
      //               new Container(
      //                 child: new Image.asset('images/Kalinga-TV-Logo.png'),
      //                 color: kalinga_color_code ,
      //                 height: 120.0,),
      //               new ListTile(
      //                 leading: new Icon(Icons.trending_up,color:Colors.grey[800] ,),
      //                 title: new Text("Top Stories",
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(0);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //
      //                 leading: new Icon(Icons.trending_up,color:Colors.grey[800] ,),
      //                 title: new Text("State",
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(1%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.location_city_rounded,color:Colors.grey[800] ,),
      //                 title: new Text("Nation",
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(2%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //
      //                 leading: new Icon(Icons.location_city_rounded,color:Colors.grey[800] ,),
      //                 title: new Text("World",
      //                   style: TextStyle(
      //                   fontFamily: 'Poppins',
      //                   fontStyle: FontStyle.normal,
      //                   fontSize: 16,
      //                   color: Colors.grey[800],
      //                   fontWeight: FontWeight.w500,
      //                 ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(3%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.public_rounded,color: Colors.grey[800] ,),
      //                 title: new Text("Entertainment",
      //                   style: TextStyle(
      //                   fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                   fontSize: 16,
      //                     color: Colors.grey[800],
      //                   fontWeight: FontWeight.w500,
      //                 ),),
      //
      //                 onTap: () {
      //                   //pageController.animateTo(pageController.initialPage+1);
      //                   _tabController.animateTo(4%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.panorama_photosphere_select,color: Colors.grey[800] ,),
      //                 title: new Text("Business"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(5%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.movie,color: Colors.grey[800] ,),
      //                 title: new Text("Sports"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(6%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.business_center_rounded,color: Colors.grey[800] ,),
      //                 title: new Text("Tech"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(7%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(PHOTO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.sports_bar_rounded,color: Colors.grey[800] ,),
      //                 title: new Text("Offbeat"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(8%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.more,color: Colors.grey[800],),
      //                 title: new Text("Miscellany"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(9%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.more,color: Colors.grey[800],),
      //                 title: new Text("Features"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   _tabController.animateTo(10%12);
      //                   Navigator.pop(context);
      //                   //Navigator.of(context).pushNamed(VIDEO_CONTAINER_SCREEN);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.video_collection,color: Colors.grey[800],),
      //                 title: new Text("Videos"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //                 onTap: () {
      //                   _tabController.animateTo(11%12);
      //                   Navigator.pop(context);
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.search,color: Colors.grey[800],),
      //                 title: new Text("Search"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   //_tabController.animateTo(9%10);
      //                   Navigator.pop(context);
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => SearchPage(),
      //                     ),
      //                   );
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.live_tv,color: Colors.grey[800],),
      //                 title: new Text("Live"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   //_tabController.animateTo(9%10);
      //                   Navigator.pop(context);
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => VideoPlayerScreen(),
      //                     ),
      //                   );
      //                 },
      //               ),
      //               new ListTile(
      //                 leading: new Icon(Icons.settings,color: Colors.grey[800],),
      //                 title: new Text("Settings"
      //                   ,
      //                   style: TextStyle(
      //                     fontFamily: 'Poppins',
      //                     fontStyle: FontStyle.normal,
      //                     fontSize: 16,
      //                     color: Colors.grey[800],
      //                     fontWeight: FontWeight.w500,
      //                   ),),
      //
      //                 onTap: () {
      //                   //_tabController.animateTo(9%10);
      //                   Navigator.pop(context);
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                        builder: (context) => SettingsApp(),
      //                     ),
      //                   );
      //                 },
      //               ),
      //             ],
      //           )),
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
                                            length: _postList.length, // length of tabs
                                            initialIndex: 1,
                                            child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                                              Container(
                                                color: Colors.black,
                                                child: TabBar(
                                                  //labelPadding: EdgeInsets.only(top:5,bottom: 5),
                                                  isScrollable: true,
                                                  labelPadding: EdgeInsets.zero,
                                                  controller: _tabController,
                                                  labelColor: Colors.white,
                                                  unselectedLabelColor: Colors.white,
                                                  indicatorSize: TabBarIndicatorSize.label,
                                                  indicatorColor: Colors.amberAccent,
                                                  tabs: List<Widget>.generate(_postList.length??CircularProgressIndicator(), (int index) {
                                                    return Tab(
                                                        child:Padding(
                                                            padding: const EdgeInsets.all(10),
                                                            child: Text(_postList[index].name??'',
                                                                style: TextStyle(
                                                                    fontWeight: FontWeight.w500, fontSize: 15.0))));
                                                  }),

                                                ),
                                              ),
                                              Container(
                                                height: MediaQuery.of(context).size.height,
                                                child: new TabBarView(
                                                  controller: _tabController,
                                                  children: List<Widget>.generate(_postList.length, (int index){
                                                    //print('CT_ITEM '+categry);
                                                    //return new Text("again some random text :"+_postList[index].subcat_id+' '+_postList[index].subcategory)
                                                    if(_postList[index].name=='Videos')
                                                      {
                                                        return YoutubeHomeScreen();
                                                      }
                                                    return news_list_page(index.toString(),_postList[index].name,_postList[index].link);

                                                  }),
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
          //),
      ),);

  }
}